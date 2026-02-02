import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OnboardingWizard extends StatefulWidget {
  const OnboardingWizard({super.key});

  @override
  State<OnboardingWizard> createState() => _OnboardingWizardState();
}

class _OnboardingWizardState extends State<OnboardingWizard>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  String gender = 'Male';
  int age = 25;
  bool isMetric = true;
  double height = 170;
  double weight = 70;
  String goal = 'Maintain';
  double targetWeight = 70;
  String activityLevel = 'Moderate';
  Set<String> dietTypes = {'Non-veg'};
  Set<String> selectedCuisines = {'Italian'};
  Set<String> allergies = {};
  double weeklyBudget = 5000;
  String cookingSkill = 'Beginner';
  String kitchenEquip = 'Basic';
  String currency = 'INR';

  final Color pastelRed = const Color(0xFFFFCDD2);
  final Color pastelGreen = const Color(0xFFC8E6C9);
  final Color pastelBlue = const Color(0xFFBBDEFB);
  final Color pastelPurple = const Color(0xFFE1BEE7);
  final Color pastelOrange = const Color(0xFFFFE0B2);
  final Color pastelYellow = const Color(0xFFFFF9C4);

  final Color primaryDark = const Color(0xFFEF6C00);

  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _progressAnimation = Tween<double>(
      begin: 0,
      end: 1 / 7,
    ).animate(_progressController);
    _progressController.forward();
  }

  void _nextPage() {
    if (_currentPage < 6) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeOutQuart,
      );
      double start = (_currentPage + 1) / 7;
      double end = (_currentPage + 2) / 7;
      _progressAnimation = Tween<double>(begin: start, end: end).animate(
        CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
      );
      _progressController.reset();
      _progressController.forward();
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeOutQuart,
      );
      double start = (_currentPage + 1) / 7;
      double end = _currentPage / 7;
      _progressAnimation = Tween<double>(begin: start, end: end).animate(
        CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
      );
      _progressController.reset();
      _progressController.forward();
    } else {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (pg) => setState(() => _currentPage = pg),
                children: [
                  _buildAnimatedPage(_buildStep1Essentials()),
                  _buildAnimatedPage(_buildStep2Body()),
                  _buildAnimatedPage(_buildStep3Mission()),
                  _buildAnimatedPage(_buildStep4Fuel()),
                  _buildAnimatedPage(_buildStep5Taste()),
                  _buildAnimatedPage(_buildStep6Kitchen()),
                  _buildAnimatedPage(_buildSummaryScreen()),
                ],
              ),
            ),
            _buildBottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedPage(Widget child) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeOutCubic,
      builder: (context, double val, _) {
        return Opacity(
          opacity: val,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - val)),
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    List<String> titles = [
      "Basic Info",
      "Measurements",
      "Your Mission",
      "Fuel Your Body",
      "Taste Profile",
      "Chef Profile",
      "Ready to Feast!",
    ];
    String currentTitle = titles[_currentPage];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Row(
        children: [
          _buildGlassyIconButton(
            icon: Icons.arrow_back_ios_new,
            onTap: _prevPage,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, anim) {
                    return FadeTransition(
                      opacity: anim,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, 0.5),
                          end: Offset.zero,
                        ).animate(anim),
                        child: child,
                      ),
                    );
                  },
                  child: currentTitle == "Basic Info"
                      ? Hero(
                          tag: "onboardingTitle",
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              "Setup Profile Now",
                              key: ValueKey<String>("Setup Profile Now"),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        )
                      : Text(
                          currentTitle,
                          key: ValueKey<String>(currentTitle),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                ),
                const SizedBox(height: 8),
                AnimatedBuilder(
                  animation: _progressController,
                  builder: (context, child) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: _progressAnimation.value,
                        backgroundColor: Colors.grey[100],
                        color: primaryDark,
                        minHeight: 8,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  Widget _buildGlassyIconButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, size: 20, color: Colors.black87),
      ),
    );
  }

  Widget _buildBottomBar() {
    bool isLastPage = _currentPage == 6;
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, -10),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          HapticFeedback.mediumImpact();
          isLastPage ? () {} : _nextPage();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: pastelOrange,
          foregroundColor: const Color(0xFFEF6C00), // Deep Orange for contrast
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLastPage ? "Start Your AnyFeast" : "Continue",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (!isLastPage) ...[
              const SizedBox(width: 10),
              const Icon(Icons.arrow_forward_rounded, size: 20),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStep1Essentials() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: pastelBlue.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 5,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.face_rounded,
                  size: 50,
                  color: Colors.blue[300],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          _buildTitle("Basic Info", "Let's get to know you better."),
          const SizedBox(height: 30),
          Row(
            children: [
              Icon(Icons.wc_rounded, color: pastelBlue),
              const SizedBox(width: 10),
              Text("Gender Identity", style: _labelStyle()),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              _buildModernCard(
                "Male",
                Icons.male,
                pastelBlue,
                Colors.blue[700]!,
                gender == 'Male',
                () => setState(() => gender = 'Male'),
                heroTag: "gender_card_0",
              ),
              const SizedBox(width: 15),
              _buildModernCard(
                "Female",
                Icons.female,
                pastelRed,
                Colors.pink[400]!,
                gender == 'Female',
                () => setState(() => gender = 'Female'),
                heroTag: "gender_card_1",
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              _buildModernCard(
                "Non-Binary",
                Icons.transgender,
                pastelPurple,
                Colors.purple[400]!,
                gender == 'Non-Binary',
                () => setState(() => gender = 'Non-Binary'),
                heroTag: "gender_card_2",
              ),
              const SizedBox(width: 15),
              _buildModernCard(
                "Other",
                Icons.person_outline,
                pastelOrange,
                Colors.orange[800]!,
                gender == 'Other',
                () => setState(() => gender = 'Other'),
                heroTag: "gender_card_3",
              ),
            ],
          ),
          const SizedBox(height: 40),
          _buildAgeSelector(),
        ],
      ),
    );
  }

  Widget _buildAgeSelector() {
    IconData ageIcon;
    if (age < 18) {
      ageIcon = gender == 'Female' ? Icons.girl_rounded : Icons.boy_rounded;
    } else if (age < 60) {
      ageIcon = Icons.accessibility_new_rounded;
    } else {
      ageIcon = Icons.elderly_rounded;
    }

    double visualHeight;
    if (age <= 20) {
      visualHeight = 40 + (age - 10) * 6.0;
    } else if (age <= 60) {
      visualHeight = 100;
    } else {
      visualHeight = 100 - (age - 60) * 0.35;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[100]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Age",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: pastelOrange,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "$age years",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            height: 120,
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutBack,
                height: visualHeight,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: Icon(
                    ageIcon,
                    key: ValueKey(ageIcon),
                    size: visualHeight,
                    color: pastelOrange,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: pastelOrange.withOpacity(0.8),
              inactiveTrackColor: Colors.grey[200],
              thumbColor: pastelOrange,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
              overlayColor: pastelOrange.withOpacity(0.2),
            ),
            child: Slider(
              value: age.toDouble(),
              min: 10,
              max: 100,
              onChanged: (v) {
                if (v.toInt() != age) {
                  HapticFeedback.selectionClick();
                  setState(() => age = v.toInt());
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "10",
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
              Text(
                "100",
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStep2Body() {
    double bmi = weight / ((height / 100) * (height / 100));

    double heightVal = isMetric ? height : height / 30.48;
    double heightMin = isMetric ? 100 : 3.0;
    double heightMax = isMetric ? 250 : 8.0;
    String heightUnit = isMetric ? "cm" : "ft";

    double weightVal = isMetric ? weight : weight * 2.20462;
    double weightMin = isMetric ? 30 : 60;
    double weightMax = isMetric ? 200 : 450;
    String weightUnit = isMetric ? "kg" : "lbs";

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(
            "Measurements",
            "Building your valid nutrition plan.",
            icon: Icons.straighten_rounded,
            iconColor: Colors.blue,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildUnitToggle(
                  "Metric",
                  isMetric,
                  () => setState(() => isMetric = true),
                ),
                _buildUnitToggle(
                  "Imperial",
                  !isMetric,
                  () => setState(() => isMetric = false),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          RulerPicker(
            value: isMetric ? height : height / 2.54,
            min: isMetric ? 100 : 40,
            max: isMetric ? 250 : 96,
            unit: isMetric ? "cm" : "height",
            color: pastelBlue,
            isImperialHeight: !isMetric,
            onChanged: (val) {
              setState(() {
                height = isMetric ? val : val * 2.54;
              });
            },
          ),

          const SizedBox(height: 40),

          RulerPicker(
            value: isMetric ? weight : weight * 2.20462,
            min: isMetric ? 30 : 66,
            max: isMetric ? 200 : 440,
            unit: isMetric ? "kg" : "lbs",
            color: pastelGreen,
            onChanged: (val) {
              setState(() {
                weight = isMetric ? val : val / 2.20462;
              });
            },
          ),

          const SizedBox(height: 40),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "ESTIMATED BMI",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown,
                      ),
                    ),
                    Text(
                      bmi.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Colors.brown,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.analytics_outlined,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep3Mission() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(
            "Your Mission",
            "What do you want to achieve?",
            icon: Icons.track_changes_rounded,
            iconColor: Colors.red,
          ),
          const SizedBox(height: 30),

          _buildDetailedGoalCard(
            title: "Lose Weight",
            subtitle: "Burn fat & get lean",
            icon: Icons.local_fire_department_rounded,
            color: pastelRed,
            accent: Colors.red,
            value: 'Lose',
          ),
          const SizedBox(height: 15),
          _buildDetailedGoalCard(
            title: "Maintain Weight",
            subtitle: "Stay healthy & balanced",
            icon: Icons.favorite_rounded,
            color: pastelGreen,
            accent: Colors.green[700]!,
            value: 'Maintain',
          ),
          const SizedBox(height: 15),
          _buildDetailedGoalCard(
            title: "Gain Muscle",
            subtitle: "Build strength & mass",
            icon: Icons.fitness_center_rounded,
            color: pastelBlue,
            accent: Colors.blue[800]!,
            value: 'Gain',
          ),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, animation) {
              return SizeTransition(
                sizeFactor: animation,
                axisAlignment: -1.0,
                child: FadeTransition(opacity: animation, child: child),
              );
            },
            child: goal != 'Maintain'
                ? Column(
                    key: ValueKey(goal),
                    children: [
                      const SizedBox(height: 40),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: pastelPurple.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.flag_rounded,
                                    size: 20,
                                    color: Colors.purple,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "Target Weight",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                if (weight > 0)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: pastelPurple.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      _getTargetDescription(),
                                      style: TextStyle(
                                        color: Colors.purple[800],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            RulerPicker(
                              value: isMetric
                                  ? targetWeight
                                  : targetWeight * 2.20462,
                              min: isMetric ? 40 : 88,
                              max: isMetric ? 150 : 330,
                              unit: isMetric ? "kg" : "lbs",
                              color: pastelPurple,
                              onChanged: (val) {
                                setState(() {
                                  targetWeight = isMetric ? val : val / 2.20462;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  String _getTargetDescription() {
    double diff = targetWeight - weight;
    String unit = isMetric ? "kg" : "lbs";
    double displayDiff = isMetric ? diff : diff * 2.20462;

    if (diff.abs() < 0.5) return "Maintain";

    if (diff < 0) {
      return "-${displayDiff.abs().toStringAsFixed(1)} $unit";
    } else {
      return "+${displayDiff.abs().toStringAsFixed(1)} $unit";
    }
  }

  Widget _buildDetailedGoalCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color accent,
    required String value,
  }) {
    bool isSelected = goal == value;
    return GestureDetector(
      onTap: () => setState(() => goal = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.25) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? accent : Colors.grey[200]!,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: accent.withOpacity(0.2),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 5,
                  ),
                ],
        ),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: isSelected ? accent : Colors.grey[100],
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey[400],
                size: 28,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.black87 : Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: isSelected ? Colors.black54 : Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Transform.scale(
                scale: 1.1,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, size: 16, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep4Fuel() {
    final Map<String, IconData> dietIcons = {
      'Vegetarian': Icons.grass_rounded,
      'Non-veg': Icons.restaurant_menu_rounded,
      'Vegan': Icons.spa_rounded,
      'Pescatarian': Icons.water_drop_rounded,
      'Keto': Icons.local_fire_department_rounded,
      'Paleo': Icons.landscape_rounded,
      'Halal': Icons.verified_rounded,
    };

    final dietDescriptions = {
      'Vegetarian': 'No meat',
      'Non-veg': 'Includes meat',
      'Vegan': 'Plant-based',
      'Pescatarian': 'Fish & veggies',
      'Keto': 'Low carb',
      'Paleo': 'Whole foods',
      'Halal': 'Halal certified',
    };

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(
            "Fuel Your Body",
            "Calculate burn & needs.",
            icon: Icons.bolt_rounded,
            iconColor: Colors.orange,
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.directions_run_rounded, color: Colors.orange),
              ),
              const SizedBox(width: 10),
              Text("Daily Activity", style: _labelStyle()),
            ],
          ),
          const SizedBox(height: 15),
          Column(
            children: [
              _buildActivityOption(
                "Sedentary",
                "Little or no exercise, desk job",
                Icons.weekend_rounded,
              ),
              _buildActivityOption(
                "Lightly Active",
                "Light exercise 1-3 days/week",
                Icons.directions_walk_rounded,
              ),
              _buildActivityOption(
                "Moderate",
                "Moderate exercise 3-5 days/week",
                Icons.directions_run_rounded,
              ),
              _buildActivityOption(
                "Very Active",
                "Hard exercise 6-7 days/week",
                Icons.fitness_center_rounded,
              ),
              _buildActivityOption(
                "Super Active",
                "Physical job or 2x training",
                Icons.flash_on_rounded,
              ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.restaurant_rounded, color: Colors.green),
              ),
              const SizedBox(width: 10),
              Text("Dietary Styles", style: _labelStyle()),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            "Select all that apply",
            style: TextStyle(color: Colors.grey[500], fontSize: 13),
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: dietIcons.keys.map((d) {
              return _buildDietCard(
                d,
                dietDescriptions[d]!,
                dietIcons[d]!,
                dietTypes.contains(d),
                () => setState(() {
                  if (dietTypes.contains(d)) {
                    if (dietTypes.length > 1) dietTypes.remove(d);
                  } else {
                    dietTypes.add(d);
                  }
                }),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStep5Taste() {
    final cuisineEmojis = {
      'Italian': '🍕',
      'Indian': '🍛',
      'Mexican': '🌮',
      'Chinese': '🥢',
      'Japanese': '🍣',
      'Thai': '🍤',
      'French': '🥐',
      'Greek': '🥗',
      'Spanish': '🥘',
      'Lebanese': '🥙',
      'German': '🥨',
      'British': '🍳',
      'Mediterranean': '🍋',
    };

    final allergyIcons = {
      'Peanuts': Icons.spa_rounded,
      'Dairy': Icons.local_drink_rounded,
      'Gluten': Icons.bakery_dining_rounded,
      'Eggs': Icons.egg_rounded,
      'Soy': Icons.grass_rounded,
      'Shellfish': Icons.set_meal_rounded,
      'Tree Nuts': Icons.forest_rounded,
      'Fish': Icons.water_drop_rounded,
    };

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(
            "Taste Profile",
            "What do you love (and avoid)?",
            icon: Icons.restaurant_menu_rounded,
            iconColor: Colors.orangeAccent,
          ),
          const SizedBox(height: 30),

          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.pink.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.public_rounded, color: Colors.pink),
              ),
              const SizedBox(width: 10),
              Text("Favorite Cuisines", style: _labelStyle()),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            "Tap to select your favorites",
            style: TextStyle(color: Colors.grey[500], fontSize: 13),
          ),
          const SizedBox(height: 15),

          Center(
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: cuisineEmojis.keys.map((c) {
                return _buildCuisineCard(
                  c,
                  cuisineEmojis[c]!,
                  selectedCuisines.contains(c),
                  () {
                    setState(() {
                      if (selectedCuisines.contains(c)) {
                        selectedCuisines.remove(c);
                      } else {
                        selectedCuisines.add(c);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 40),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.05),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.red.withOpacity(0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.red[400],
                      size: 28,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Allergies & Restrictions",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[800],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: allergyIcons.keys.map((a) {
                    return _buildAllergyChip(
                      a,
                      allergyIcons[a]!,
                      allergies.contains(a),
                      () {
                        setState(() {
                          if (allergies.contains(a)) {
                            allergies.remove(a);
                          } else {
                            allergies.add(a);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep6Kitchen() {
    String symbol = '₹';
    double min = 1000;
    double max = 15000;

    if (currency == 'EUR') {
      symbol = '€';
      min = 50;
      max = 400;
    } else if (currency == 'GBP') {
      symbol = '£';
      min = 40;
      max = 350;
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(
            "Chef Profile",
            "Budget & Skills Setup.",
            icon: Icons.kitchen_rounded,
            iconColor: Colors.green,
          ),
          const SizedBox(height: 30),

          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: pastelGreen.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.savings_rounded,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Weekly Budget",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          _buildCompactCurrencyToggle("₹", "INR"),
                          _buildCompactCurrencyToggle("€", "EUR"),
                          _buildCompactCurrencyToggle("£", "GBP"),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Column(
                  children: [
                    Text(
                      "$symbol ${weeklyBudget.toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w900,
                        color: Colors.green[800],
                        letterSpacing: -1.0,
                      ),
                    ),
                    Text(
                      "target limit",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.green,
                    inactiveTrackColor: Colors.green.withOpacity(0.1),
                    trackHeight: 12,
                    thumbColor: Colors.white,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 16,
                      elevation: 4,
                      pressedElevation: 8,
                    ),
                    overlayColor: Colors.green.withOpacity(0.1),
                    overlayShape: const RoundSliderOverlayShape(
                      overlayRadius: 32,
                    ),
                  ),
                  child: Slider(
                    value: weeklyBudget.clamp(min, max),
                    min: min,
                    max: max,
                    onChanged: (v) {
                      setState(() {
                        double snap = currency == 'INR' ? 100 : 5;
                        weeklyBudget = (v / snap).round() * snap;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "$symbol${min.toInt()}",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "$symbol${max.toInt()}",
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),

          const SizedBox(height: 40),

          Row(
            children: [
              Icon(Icons.emoji_events_rounded, color: Colors.orange),
              const SizedBox(width: 10),
              Text("Cooking Skill", style: _labelStyle()),
            ],
          ),
          const SizedBox(height: 15),
          Column(
            children: [
              _buildSkillOption(
                "Beginner",
                "Can boil water & make toast",
                "🍳",
                Colors.orange,
              ),
              _buildSkillOption(
                "Intermediate",
                "Comfortable with most recipes",
                "🍜",
                Colors.deepOrange,
              ),
              _buildSkillOption(
                "Expert",
                "Master Chef in the making",
                "👨‍🍳",
                Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCompactCurrencyToggle(String symbol, String code) {
    bool isSelected = currency == code;
    return GestureDetector(
      onTap: () {
        setState(() {
          currency = code;
          if (code == 'INR') weeklyBudget = 5000;
          if (code == 'EUR') weeklyBudget = 150;
          if (code == 'GBP') weeklyBudget = 120;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Text(
          symbol,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.black87 : Colors.grey[400],
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildSkillOption(
    String title,
    String subtitle,
    String emoji,
    Color color,
  ) {
    bool isSelected = cookingSkill == title;
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() => cookingSkill = title);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : Colors.grey[200]!,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Text(emoji, style: const TextStyle(fontSize: 24)),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.black87 : Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      color: isSelected
                          ? color.withOpacity(0.8)
                          : Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: color, size: 28),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryScreen() {
    double heightM = height / 100;
    double bmi = weight / (heightM * heightM);
    String bmiCategory;
    Color bmiColor;
    IconData bmiIcon;

    if (bmi < 18.5) {
      bmiCategory = "Underweight";
      bmiColor = Colors.blue;
      bmiIcon = Icons.opacity_rounded;
    } else if (bmi < 25) {
      bmiCategory = "Healthy";
      bmiColor = Colors.green;
      bmiIcon = Icons.check_circle_rounded;
    } else if (bmi < 30) {
      bmiCategory = "Overweight";
      bmiColor = Colors.orange;
      bmiIcon = Icons.warning_rounded;
    } else {
      bmiCategory = "Obese";
      bmiColor = Colors.red;
      bmiIcon = Icons.health_and_safety_rounded;
    }

    double s = (gender == 'Male') ? 5 : -161;
    double bmr = (10 * weight) + (6.25 * height) - (5 * age) + s;

    double activityMultiplier = 1.2;
    if (activityLevel == 'Lightly Active') activityMultiplier = 1.375;
    if (activityLevel == 'Moderately Active') activityMultiplier = 1.55;
    if (activityLevel == 'Very Active') activityMultiplier = 1.725;
    if (activityLevel.contains('Extra') || activityLevel.contains('Athlete')) {
      activityMultiplier = 1.9;
    }

    double tdee = bmr * activityMultiplier;

    double dailyCalorieGoal = tdee;
    double proteinTarget = weight * 1.6;
    String weeklyPacing = "Maintain";

    if (goal.contains('Lose')) {
      dailyCalorieGoal = tdee - 500;
      proteinTarget = weight * 2.0;
      weeklyPacing = "-0.5 kg/week";
    } else if (goal.contains('Muscle') || goal.contains('Gain')) {
      dailyCalorieGoal = tdee + 300;
      proteinTarget = weight * 2.2;
      weeklyPacing = "+0.25 kg/week";
    } else {
      weeklyPacing = "Stable Weight";
      proteinTarget = weight * 1.6;
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 800),
            curve: Curves.elasticOut,
            builder: (context, val, child) {
              return Transform.scale(
                scale: val,
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [pastelOrange, Colors.white],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.celebration_rounded,
                    size: 60,
                    color: Colors.deepOrange,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          const Text(
            "Ready to Feast!",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Colors.black87,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Your personalized plan is ready.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 40),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFFEF6C00), Colors.orange.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  "DAILY TARGET",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      dailyCalorieGoal.toStringAsFixed(0),
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8, left: 4),
                      child: Text(
                        "kcal",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.bolt_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${proteinTarget.toStringAsFixed(0)}g Protein",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          _buildSummarySectionHeader(
            "Health Metrics",
            Icons.insights_rounded,
            Colors.purple,
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1.4,
            children: [
              _buildMetricCard(
                "BMI",
                bmi.toStringAsFixed(1),
                bmiCategory,
                bmiColor,
                Icons.accessibility_new_rounded,
              ),
              _buildMetricCard(
                "BMR",
                bmr.toStringAsFixed(0),
                "Calories/day",
                Colors.blue,
                Icons.local_fire_department_rounded,
              ),
              _buildMetricCard(
                "TDEE",
                tdee.toStringAsFixed(0),
                "Maintenance",
                Colors.teal,
                Icons.speed_rounded,
              ),
              _buildMetricCard(
                "Goal",
                goal,
                weeklyPacing,
                Colors.pink,
                Icons.flag_rounded,
              ),
            ],
          ),

          const SizedBox(height: 30),

          _buildSummarySectionHeader(
            "Your Profile",
            Icons.person_pin_rounded,
            Colors.blueGrey,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildProfileRow(
                  Icons.directions_run_rounded,
                  "Activity",
                  activityLevel,
                  Colors.blue,
                ),
                _buildProfileRow(
                  Icons.restaurant_rounded,
                  "Diet",
                  dietTypes.join(", "),
                  Colors.green,
                ),
                _buildProfileRow(
                  Icons.public,
                  "Cuisine",
                  selectedCuisines.join(", "),
                  Colors.orange,
                ),
                _buildProfileRow(
                  Icons.warning_rounded,
                  "Allergies",
                  allergies.isEmpty ? "None" : allergies.join(", "),
                  Colors.red,
                ),
                Divider(height: 30, color: Colors.grey[100]),
                _buildProfileRow(
                  Icons.savings_rounded,
                  "Budget",
                  "$currency $weeklyBudget/wk",
                  Colors.teal,
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    String subtitle,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: color.withOpacity(0.1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(icon, size: 18, color: color),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfileRow(
    IconData icon,
    String label,
    String value,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySectionHeader(String title, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(
    String title,
    String subtitle, {
    String? heroTag,
    IconData? icon,
    Color? iconColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heroTag != null
                  ? Hero(
                      tag: heroTag,
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  : Text(
                      title,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[500],
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        if (icon != null)
          Transform.rotate(
            angle: 0.2,
            child: Icon(
              icon,
              size: 80,
              color: (iconColor ?? Colors.grey).withOpacity(0.1),
            ),
          ),
      ],
    );
  }

  TextStyle _labelStyle() => const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Colors.black87,
  );

  // Modern Card for Gender, etc.
  Widget _buildModernCard(
    String title,
    IconData icon,
    Color bg,
    Color accent,
    bool isSelected,
    VoidCallback onTap, {
    String? heroTag,
  }) {
    Widget cardContent = AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      // padding: const EdgeInsets.symmetric(vertical: 24), // Removed padding to use Stack fully
      decoration: BoxDecoration(
        color: isSelected ? bg : Colors.grey[50],
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isSelected ? accent : Colors.transparent,
          width: 2,
        ),
        boxShadow: isSelected
            ? [BoxShadow(color: bg, blurRadius: 10, offset: const Offset(0, 5))]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Decorative Watermark
            Positioned(
              right: -15,
              bottom: -15,
              child: Transform.rotate(
                angle: -0.2,
                child: Icon(
                  icon,
                  size: 80,
                  color: isSelected
                      ? Colors.white.withOpacity(0.3)
                      : Colors.grey.withOpacity(0.05),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      icon,
                      size: 36,
                      color: isSelected ? accent : Colors.grey[400],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isSelected ? Colors.black87 : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return Expanded(
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        child: heroTag != null
            ? Hero(
                tag: heroTag,
                child: Material(
                  type: MaterialType.transparency,
                  child: cardContent,
                ),
              )
            : cardContent,
      ),
    );
  }

  // Modern Goal Option
  Widget _buildGoalOption(
    String title,
    Color bg,
    Color accent,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? bg.withOpacity(0.4) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? accent : Colors.grey[200]!,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.black54),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            if (isSelected)
              Icon(Icons.check_circle_rounded, color: accent, size: 28),
          ],
        ),
      ),
    );
  }

  // Pastel Chip
  Widget _buildPastelChip(
    String label,
    bool isSelected,
    VoidCallback onTap, {
    Color? color,
  }) {
    Color activeColor = color ?? pastelBlue;
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey[300]!,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: activeColor.withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black87 : Colors.grey[600],
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  // Slider Wrapper
  Widget _buildValueSlider(
    String label,
    double value,
    String unit,
    double min,
    double max,
    Color color,
    ValueChanged<double> onChanged, {
    bool isDecimal = false,
    IconData? icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey[100]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (icon != null) ...[
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icon, size: 18, color: Colors.black54),
                    ),
                    const SizedBox(width: 10),
                  ],
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  isDecimal
                      ? "${value.toStringAsFixed(1)} $unit"
                      : "${value.toInt()} $unit",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: color.withOpacity(0.8),
              inactiveTrackColor: Colors.grey[200],
              thumbColor: color, // Pastel thumb
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
              overlayColor: color.withOpacity(0.2),
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              onChanged: (val) {
                // Haptic feedback logic
                if (isDecimal) {
                  // For decimals (imperial height), vibrate on every 0.1 change
                  if ((val * 10).toInt() != (value * 10).toInt()) {
                    HapticFeedback.selectionClick();
                  }
                } else {
                  // For integers, vibrate on every whole number change
                  if (val.toInt() != value.toInt()) {
                    HapticFeedback.selectionClick();
                  }
                }
                onChanged(val);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnitToggle(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.black87 : Colors.grey[600],
          ),
        ),
      ),
    );
  }

  Widget _buildEmojiCard(
    String emoji,
    String title,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: isSelected ? pastelOrange : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? Colors.orange : Colors.grey[200]!,
                width: 2,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: pastelOrange,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ]
                  : [],
            ),
            child: Text(emoji, style: const TextStyle(fontSize: 32)),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.black87 : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconCircle(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 20),
    );
  }

  Widget _buildDietCard(
    String title,
    String subtitle,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 100, // Fixed width for grid look
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
        decoration: BoxDecoration(
          color: isSelected ? pastelGreen : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey[200]!,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.5)
                    : Colors.grey[50],
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.green[800] : Colors.grey[400],
                size: 24,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12, // Compact
                color: isSelected ? Colors.black87 : Colors.grey[700],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: isSelected ? Colors.green[900] : Colors.grey[400],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCuisineCard(
    String label,
    String emoji,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 100, // Square shape
        height: 100,
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.grey[200]!,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.black87 : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllergyChip(
    String label,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.red : Colors.red.withOpacity(0.2),
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : Colors.red[300],
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.red[800],
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityOption(String title, String subtitle, IconData icon) {
    bool isSelected = activityLevel == title;
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() => activityLevel = title);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.grey[200]!,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.orange : Colors.grey[100],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey[400],
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isSelected ? Colors.black87 : Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.orange[800] : Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: Colors.orange,
                size: 28,
              ),
          ],
        ),
      ),
    );
  }
}

class RulerPicker extends StatefulWidget {
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;
  final String unit;
  final Color color;
  final bool isImperialHeight; // Special flag for Ft/In formatting

  const RulerPicker({
    super.key,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.unit,
    required this.color,
    this.isImperialHeight = false,
  });

  @override
  State<RulerPicker> createState() => _RulerPickerState();
}

class _RulerPickerState extends State<RulerPicker> {
  late ScrollController _scrollController;
  final double _tickWidth = 10.0;
  // Center padding to ensure first/last items can be centered
  double _centerPadding = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _centerPadding = MediaQuery.of(context).size.width / 2;
      _jumpToValue(widget.value);
    });
  }

  @override
  void didUpdateWidget(RulerPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      // Only jump if the drift is significant (to avoid fighting the user scroll)
      // or if unit changed (implied by min/max change usually)
      if ((oldWidget.value - widget.value).abs() > 0.5 &&
          !_scrollController.position.isScrollingNotifier.value) {
        _jumpToValue(widget.value);
      }
    }
  }

  void _jumpToValue(double val) {
    if (!_scrollController.hasClients) return;
    double offset = (val - widget.min) * _tickWidth;
    _scrollController.jumpTo(offset);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int itemCount = (widget.max - widget.min).round() + 1;

    // Current Display Value Logic
    String displayValue = "";
    if (widget.isImperialHeight) {
      int inches = widget.value.round();
      int ft = inches ~/ 12;
      int inch = inches % 12;
      displayValue = "$ft' $inch\"";
    } else {
      displayValue = "${widget.value.round()}"; // ${widget.unit} outside
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            // 1. Digital Display
            Column(
              children: [
                Text(
                  displayValue,
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: widget.color.withOpacity(
                      0.8,
                    ), // pastel but dark enough
                    letterSpacing: -2,
                  ),
                ),
                Text(
                  widget.unit.toUpperCase(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[400],
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 2. The Ruler
            SizedBox(
              height: 60,
              child: Stack(
                children: [
                  NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollUpdateNotification) {
                        double offset = _scrollController.offset;
                        double relativeVal = offset / _tickWidth;
                        double newVal = widget.min + relativeVal;
                        // Clamp
                        if (newVal < widget.min) newVal = widget.min;
                        if (newVal > widget.max) newVal = widget.max;

                        if (newVal != widget.value) {
                          widget.onChanged(newVal);
                          // Haptic on integer crossing
                          if (newVal.floor() != widget.value.floor()) {
                            HapticFeedback.selectionClick();
                          }
                        }
                      }
                      return true;
                    },
                    child: ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: itemCount,
                      padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth / 2,
                      ),
                      itemBuilder: (context, index) {
                        double val = widget.min + index;
                        bool isMajor = val % 10 == 0;
                        if (widget.isImperialHeight) {
                          isMajor = val % 12 == 0; // Highlight feet
                        }

                        return Container(
                          width: _tickWidth,
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (isMajor)
                                SizedBox(
                                  height: 15,
                                  child: OverflowBox(
                                    maxWidth: 40,
                                    child: Text(
                                      "${val.toInt()}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 5),
                              Container(
                                height: isMajor ? 30 : 15,
                                width: isMajor ? 3 : 2,
                                decoration: BoxDecoration(
                                  color: isMajor
                                      ? widget.color
                                      : Colors.grey[300],
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  // Pointer
                  Center(
                    child: Container(
                      height: 40,
                      width: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF6C00), // Active pointer color
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
