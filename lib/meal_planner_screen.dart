import 'package:flutter/material.dart';
import 'onboarding_flow.dart';

class MealPlannerScreen extends StatefulWidget {
  const MealPlannerScreen({super.key});

  @override
  State<MealPlannerScreen> createState() => _MealPlannerScreenState();
}

class _MealPlannerScreenState extends State<MealPlannerScreen> {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();

  final Color pastelRed = const Color(0xFFFFCDD2);
  final Color pastelGreen = const Color(0xFFC8E6C9);
  final Color pastelBlue = const Color(0xFFBBDEFB);
  final Color pastelOrange = const Color(0xFFFFE0B2);
  final Color primaryDark = const Color(0xFFB71C1C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _buildAppBar(),
      body: _selectedIndex == 0
          ? _buildPlannerBody()
          : Center(child: Text("Coming Soon")),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: _selectedIndex == 0 ? _buildFAB() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hello, Chef!",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.normal,
            ),
          ),
          const Text(
            "Weekly Plan",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: CircleAvatar(
            backgroundColor: pastelRed,
            child: const Icon(Icons.person, color: Colors.red),
          ),
          onPressed: () {},
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  Widget _buildPlannerBody() {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverToBoxAdapter(child: _buildDateStrip()),
        SliverToBoxAdapter(child: _buildProgressCard()),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildSectionTitle("Today's Meals"),
              const SizedBox(height: 15),
              _buildMealCard(
                "Breakfast",
                "08:00 AM",
                "Avocado Toast & Eggs",
                "350 kcal",
                Icons.wb_sunny_rounded,
                pastelOrange,
              ),
              _buildMealCard(
                "Lunch",
                "13:00 PM",
                "Grilled Chicken Salad",
                "450 kcal",
                Icons.wb_cloudy_rounded,
                pastelBlue,
              ),
              _buildMealCard(
                "Snack",
                "16:30 PM",
                "Greek Yogurt Bowl",
                "150 kcal",
                Icons.coffee_rounded,
                pastelGreen,
              ),
              _buildMealCard(
                "Dinner",
                "20:00 PM",
                "Salmon & Quinoa",
                "550 kcal",
                Icons.nights_stay_rounded,
                pastelRed,
              ),
              const SizedBox(height: 100),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildDateStrip() {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final dates = ['12', '13', '14', '15', '16', '17', '18'];
    int selectedIndex = 2;

    return Container(
      height: 100,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 7,
        itemBuilder: (context, index) {
          bool isSelected = index == selectedIndex;
          Widget dateBox = Container(
            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 15),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 60,
              decoration: BoxDecoration(
                color: isSelected ? primaryDark : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: primaryDark.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 4,
                        ),
                      ],
                border: Border.all(
                  color: isSelected ? Colors.transparent : Colors.grey[200]!,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    days[index],
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.white70 : Colors.grey[500],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dates[index],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          );

          if (index < 4) {
            return Hero(
              tag: "gender_card_$index",
              child: Material(type: MaterialType.transparency, child: dateBox),
            );
          }

          return dateBox;
        },
      ),
    );
  }

  Widget _buildProgressCard() {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFE0B2), Color(0xFFFFCC80)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFE0B2).withOpacity(0.6),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              top: -20,
              child: Icon(
                Icons.lunch_dining_rounded,
                size: 120,
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            Positioned(
              bottom: -20,
              right: 50,
              child: Transform.rotate(
                angle: -0.5,
                child: Icon(
                  Icons.restaurant_menu_rounded,
                  size: 90,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
            Positioned(
              top: 40,
              left: -30,
              child: Transform.rotate(
                angle: 0.5,
                child: Icon(
                  Icons.eco_rounded,
                  size: 80,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.auto_awesome,
                          color: Color(0xFFEF6C00),
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Expanded(
                        child: Text(
                          "Tailor your feast!",
                          style: TextStyle(
                            color: Color(0xFF5D4037),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Complete your health profile to generate personalized meals specifically for you.",
                    style: TextStyle(color: Color(0xFF795548), height: 1.4),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: const Duration(
                              milliseconds: 1000,
                            ),
                            reverseTransitionDuration: const Duration(
                              milliseconds: 1000,
                            ),
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const OnboardingWizard(),
                            transitionsBuilder:
                                (
                                  context,
                                  animation,
                                  secondaryAnimation,
                                  child,
                                ) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFFEF6C00),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Hero(
                        tag: "onboardingTitle",
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            "Setup Profile Now",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFFEF6C00),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Icon(Icons.more_horiz, color: Colors.grey),
      ],
    );
  }

  Widget _buildMealCard(
    String mealType,
    String time,
    String title,
    String calories,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: Colors.black54),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      mealType.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.access_time_rounded,
                      size: 12,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  calories,
                  style: TextStyle(
                    fontSize: 12,
                    color: primaryDark,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryDark,
        unselectedItemColor: Colors.grey[400],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded),
            label: 'Plan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu_rounded),
            label: 'Recipes',
          ),
          BottomNavigationBarItem(icon: SizedBox.shrink(), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket_rounded),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: primaryDark,
      elevation: 4,
      child: const Icon(Icons.add_rounded, size: 32),
    );
  }
}
