import 'package:flutter/material.dart';

void main() => runApp(
  const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MealPlannerScreen(),
  ),
);

class MealPlannerScreen extends StatelessWidget {
  const MealPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: Row(
          children: [
            Icon(Icons.calendar_today_outlined, color: Colors.red[800]),
            const SizedBox(width: 8),
            const Text(
              'Weekly Meal Planner',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.auto_awesome, color: Colors.red[800]),
            onPressed: () {},
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Calendar Icon Placeholder
            Icon(
              Icons.calendar_month_outlined,
              size: 120,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 40),
            // Main Title
            const Text(
              'Complete Your Profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            // Description Text
            Text(
              'Complete your health profile to generate personalized meal plans based on your goals, preferences, and dietary needs.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),
            // Red Rounded Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HealthProfileSetup(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB71C1C), // Dark Red
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: const Text(
                  'Complete Profile',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HealthProfileSetup extends StatefulWidget {
  const HealthProfileSetup({super.key});

  @override
  State<HealthProfileSetup> createState() => _HealthProfileSetupState();
}

class _HealthProfileSetupState extends State<HealthProfileSetup> {
  String selectedGender = 'Male'; // Initial selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.close, color: Colors.black),
        title: const Text(
          'Health Profile Setup',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Section
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Step 1 of 12', style: TextStyle(color: Colors.grey)),
                Text(
                  '8%',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: 0.08,
              backgroundColor: Colors.grey[200],
              color: Colors.red[900],
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 30),

            // Header Image/Icon
            const Icon(Icons.person, size: 80, color: Colors.blue),
            const SizedBox(height: 20),

            const Text(
              'What is your gender?',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Subtitle with Icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.chat_bubble_outline,
                  size: 20,
                  color: Colors.grey,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'This helps us calculate your nutritional needs accurately.',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Tip/Info Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF3E5F5), // Light purple
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.auto_awesome, color: Colors.orangeAccent),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '💪 Men typically need 400-500 more calories than women due to higher muscle mass!',
                      style: TextStyle(color: Colors.purple, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Selection Options
            GenderCard(
              label: 'Male',
              icon: Icons.male,
              isSelected: selectedGender == 'Male',
              onTap: () => setState(() => selectedGender = 'Male'),
            ),
            GenderCard(
              label: 'Female',
              icon: Icons.female,
              isSelected: selectedGender == 'Female',
              onTap: () => setState(() => selectedGender = 'Female'),
            ),
            GenderCard(
              label: 'Other',
              icon: Icons.person_outline,
              isSelected: selectedGender == 'Other',
              onTap: () => setState(() => selectedGender = 'Other'),
            ),

            const SizedBox(height: 40),

            // Next Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BirthDateSetup(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB71C1C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Next',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GenderCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderCard({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFDECEA) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? const Color(0xFFB71C1C) : Colors.grey[300]!,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
              color: isSelected ? const Color(0xFFB71C1C) : Colors.grey,
            ),
            const SizedBox(width: 20),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isSelected ? const Color(0xFFB71C1C) : Colors.black87,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: Color(0xFFB71C1C)),
          ],
        ),
      ),
    );
  }
}

class BirthDateSetup extends StatefulWidget {
  const BirthDateSetup({super.key});

  @override
  State<BirthDateSetup> createState() => _BirthDateSetupState();
}

class _BirthDateSetupState extends State<BirthDateSetup> {
  // Initial values based on the screenshot
  String selectedDay = '24';
  String selectedMonth = 'August';
  String selectedYear = '1990';

  final List<String> days = List.generate(
    31,
    (index) => (index + 1).toString(),
  );
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  final List<String> years = List.generate(
    100,
    (index) => (2024 - index).toString(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          'Health Profile Setup',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Section
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Step 2 of 12', style: TextStyle(color: Colors.grey)),
                Text(
                  '16%',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: 0.16, // Progress updated to 16%
              backgroundColor: Colors.grey[200],
              color: Colors.red[900],
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 30),

            // Birthday Icon (Custom Red Icon)
            Icon(Icons.cake_outlined, size: 60, color: Colors.red[900]),
            const SizedBox(height: 20),

            const Text(
              'When were you born?',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Your age helps us personalize your nutrition plan.',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 30),

            // Dropdown Row
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildDropdownField(
                    'Day',
                    days,
                    selectedDay,
                    (val) => setState(() => selectedDay = val!),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 3,
                  child: _buildDropdownField(
                    'Month',
                    months,
                    selectedMonth,
                    (val) => setState(() => selectedMonth = val!),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: _buildDropdownField(
                    'Year',
                    years,
                    selectedYear,
                    (val) => setState(() => selectedYear = val!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // Info Box (Blue)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD), // Light blue
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.blue),
                  const SizedBox(width: 12),
                  Text(
                    'You are 35 years old',
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),

            // Next Button
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MeasurementSetup(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB71C1C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Next',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField(
    String label,
    List<String> items,
    String value,
    ValueChanged<String?> onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: value,
              items: items.map((String item) {
                return DropdownMenuItem<String>(value: item, child: Text(item));
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

class MeasurementSetup extends StatefulWidget {
  const MeasurementSetup({super.key});

  @override
  State<MeasurementSetup> createState() => _MeasurementSetupState();
}

class _MeasurementSetupState extends State<MeasurementSetup> {
  bool isMetric = true; // State to track unit selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          'Health Profile Setup',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Section (Step 3 - 25%)
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Step 3 of 12', style: TextStyle(color: Colors.grey)),
                Text(
                  '25%',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: 0.25,
              backgroundColor: Colors.grey[200],
              color: Colors.red[900],
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 30),

            // Height/Measurement Icon
            Icon(Icons.height, size: 60, color: Colors.red[900]),
            const SizedBox(height: 20),

            const Text(
              'What are your measurements?',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'This helps us calculate your calorie and nutrition targets.',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 30),

            // Custom Unit Toggle
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildUnitButton(
                      "Metric (cm/kg)",
                      isMetric,
                      () => setState(() => isMetric = true),
                    ),
                  ),
                  Expanded(
                    child: _buildUnitButton(
                      "Imperial (ft/lbs)",
                      !isMetric,
                      () => setState(() => isMetric = false),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Height Input
            _buildInputField(
              label: "Height",
              hint: isMetric ? "e.g., 170" : "e.g., 5'8\"",
              unit: isMetric ? "cm" : "ft/in",
              icon: Icons.height,
            ),
            const SizedBox(height: 20),

            // Weight Input
            _buildInputField(
              label: "Weight",
              hint: isMetric ? "e.g., 70" : "e.g., 154",
              unit: isMetric ? "kg" : "lbs",
              icon: Icons.monitor_weight_outlined,
            ),

            const Spacer(),

            // Next Button
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GoalSetupScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB71C1C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Next',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Unit Toggle Button Builder
  Widget _buildUnitButton(String title, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: active ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: active
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                  ),
                ]
              : [],
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: active ? Colors.red[900] : Colors.grey,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  // Input Field Builder
  Widget _buildInputField({
    required String label,
    required String hint,
    required String unit,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        const SizedBox(height: 8),
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400]),
            prefixIcon: Icon(icon, color: Colors.red[900]),
            suffixText: unit,
            suffixStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
          ),
        ),
      ],
    );
  }
}

class GoalSetupScreen extends StatefulWidget {
  const GoalSetupScreen({super.key});

  @override
  State<GoalSetupScreen> createState() => _GoalSetupScreenState();
}

class _GoalSetupScreenState extends State<GoalSetupScreen> {
  String selectedGoal = 'Maintain Weight'; // Default selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          'Health Profile Setup',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Section (Step 4 - 33%)
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Step 4 of 12', style: TextStyle(color: Colors.grey)),
                Text(
                  '33%',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: 0.33,
              backgroundColor: Colors.grey[200],
              color: Colors.red[900],
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 30),

            // Goal Flag Icon
            Icon(Icons.flag_outlined, size: 60, color: Colors.red[900]),
            const SizedBox(height: 20),

            const Text(
              'What is your primary goal?',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'This determines your calorie and nutrition targets.',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 30),

            // Goal Options
            GoalCard(
              title: 'Lose Weight',
              icon: Icons.trending_down,
              isSelected: selectedGoal == 'Lose Weight',
              onTap: () => setState(() => selectedGoal = 'Lose Weight'),
            ),
            GoalCard(
              title: 'Maintain Weight',
              icon: Icons.trending_flat,
              isSelected: selectedGoal == 'Maintain Weight',
              onTap: () => setState(() => selectedGoal = 'Maintain Weight'),
            ),
            GoalCard(
              title: 'Gain Weight',
              icon: Icons.trending_up,
              isSelected: selectedGoal == 'Gain Weight',
              onTap: () => setState(() => selectedGoal = 'Gain Weight'),
            ),

            const Spacer(),

            // Next Button
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TargetWeightSetup(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB71C1C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Next',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GoalCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const GoalCard({
    super.key,
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Colors based on the screenshot (Green theme for selection)
    final Color activeColor = const Color(0xFF2E7D32); // Dark Green
    final Color activeBg = const Color(0xFFE8F5E9); // Light Green

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: isSelected ? activeBg : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? activeColor : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 28,
              color: isSelected ? activeColor : Colors.grey[600],
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isSelected ? activeColor : Colors.black87,
              ),
            ),
            const Spacer(),
            if (isSelected) Icon(Icons.check_circle, color: activeColor),
          ],
        ),
      ),
    );
  }
}

class TargetWeightSetup extends StatefulWidget {
  const TargetWeightSetup({super.key});

  @override
  State<TargetWeightSetup> createState() => _TargetWeightSetupState();
}

class _TargetWeightSetupState extends State<TargetWeightSetup> {
  // Logic to determine unit based on previous steps
  bool isMetric = true;
  double currentWeight = 70.0;

  @override
  Widget build(BuildContext context) {
    String unit = isMetric ? "kg" : "lbs";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          'Health Profile Setup',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Section (Step 5 - 41%)
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Step 5 of 12', style: TextStyle(color: Colors.grey)),
                Text(
                  '41%',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: 0.41,
              backgroundColor: Colors.grey[200],
              color: Colors.red[900],
              borderRadius: BorderRadius.circular(10),
            ),
            const SizedBox(height: 30),

            // Target Icon (Circular bullseye style)
            Icon(Icons.track_changes, size: 60, color: Colors.red[900]),
            const SizedBox(height: 20),

            const Text(
              'What is your target weight?',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Dynamic Current Weight Display
            Text(
              'Your current weight is $currentWeight $unit',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 30),

            // Input Field Label
            const Text(
              "Target Weight",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            const SizedBox(height: 12),

            // Target Weight TextField
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red[900]!, width: 1.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      Icons.monitor_weight_outlined,
                      size: 18,
                      color: Colors.red[900],
                    ),
                  ),
                ),
                suffixText: unit,
                suffixStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                hintText: isMetric ? "75" : "165",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.red[900]!, width: 2),
                ),
              ),
            ),

            const Spacer(),

            // Next Button
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PacingSetupScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB71C1C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Next',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PacingSetupScreen extends StatefulWidget {
  const PacingSetupScreen({super.key});

  @override
  State<PacingSetupScreen> createState() => _PacingSetupScreenState();
}

class _PacingSetupScreenState extends State<PacingSetupScreen> {
  // Initial selection matching your screenshot
  String selectedPace = 'Maximum';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          'Health Profile Setup',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress Section (Step 6 - 50%)
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Step 6 of 12',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        '50%',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: 0.50,
                    backgroundColor: Colors.grey[200],
                    color: Colors.red[900],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  const SizedBox(height: 30),

                  // Speedometer Icon
                  Icon(Icons.speed_outlined, size: 60, color: Colors.red[900]),
                  const SizedBox(height: 20),

                  const Text(
                    'How fast do you want to gain?',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'A moderate pace is usually more sustainable.',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 30),

                  // Pace Options
                  PaceCard(
                    title: 'Slow & Steady',
                    subtitle: '0.25 kg/week - Sustainable',
                    isSelected: selectedPace == 'Slow & Steady',
                    onTap: () => setState(() => selectedPace = 'Slow & Steady'),
                  ),
                  PaceCard(
                    title: 'Moderate',
                    subtitle: '0.5 kg/week - Recommended',
                    isSelected: selectedPace == 'Moderate',
                    onTap: () => setState(() => selectedPace = 'Moderate'),
                  ),
                  PaceCard(
                    title: 'Aggressive',
                    subtitle: '0.75 kg/week - Challenging',
                    isSelected: selectedPace == 'Aggressive',
                    onTap: () => setState(() => selectedPace = 'Aggressive'),
                  ),
                  PaceCard(
                    title: 'Maximum',
                    subtitle: '1.0 kg/week - Very Challenging',
                    isSelected: selectedPace == 'Maximum',
                    onTap: () => setState(() => selectedPace = 'Maximum'),
                  ),
                ],
              ),
            ),
          ),

          // Next Button (Fixed at bottom)
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ActivitySetupScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB71C1C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Next',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PaceCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const PaceCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFDECEA) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? const Color(0xFFB71C1C) : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? const Color(0xFFB71C1C)
                          : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected
                          ? const Color(0xFFB71C1C).withOpacity(0.7)
                          : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: Color(0xFFB71C1C)),
          ],
        ),
      ),
    );
  }
}

class ActivitySetupScreen extends StatefulWidget {
  const ActivitySetupScreen({super.key});

  @override
  State<ActivitySetupScreen> createState() => _ActivitySetupScreenState();
}

class _ActivitySetupScreenState extends State<ActivitySetupScreen> {
  String selectedLevel = 'Very Active';
  final Set<String> selectedActivities = {
    'Running',
    'Swimming',
    'Cycling',
    'Yoga',
  };

  final List<Map<String, dynamic>> levels = [
    {
      'title': 'Sedentary',
      'desc': 'Little or no exercise',
      'icon': Icons.chair_outlined,
    },
    {
      'title': 'Light',
      'desc': 'Exercise 1-3 times/week',
      'icon': Icons.directions_walk,
    },
    {
      'title': 'Moderate',
      'desc': 'Exercise 4-5 times/week',
      'icon': Icons.fitness_center,
    },
    {
      'title': 'Very Active',
      'desc': 'Exercise 6-7 times/week',
      'icon': Icons.bolt,
    },
    {
      'title': 'Extra Active',
      'desc': 'Intense exercise daily',
      'icon': Icons.speed,
    },
  ];

  final List<Map<String, String>> activities = [
    {'name': 'Running', 'emoji': '🏃'},
    {'name': 'Swimming', 'emoji': '🏊'},
    {'name': 'Cycling', 'emoji': '🚴'},
    {'name': 'Yoga', 'emoji': '🧘'},
    {'name': 'Weight Training', 'emoji': '🏋️'},
    {'name': 'Dancing', 'emoji': '💃'},
    {'name': 'Sports', 'emoji': '⚽'},
    {'name': 'Walking', 'emoji': '🚶'},
    {'name': 'Other', 'emoji': '🤸'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          'Health Profile Setup',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProgressHeader(),
                  const SizedBox(height: 20),
                  const Text(
                    'How active are you?',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  _buildInfoBox(),
                  const SizedBox(height: 20),

                  ...levels.map((level) => _buildLevelCard(level)).toList(),

                  const SizedBox(height: 30),
                  const Text(
                    "What's your main activity?",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Select all that apply (optional)',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),

                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: activities
                        .map((act) => _buildActivityChip(act))
                        .toList(),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          _buildNextButton(),
        ],
      ),
    );
  }

  Widget _buildProgressHeader() {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Step 7 of 12', style: TextStyle(color: Colors.grey)),
            Text(
              '58%',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: 0.58,
          backgroundColor: Colors.grey[200],
          color: Colors.red[900],
          borderRadius: BorderRadius.circular(10),
        ),
      ],
    );
  }

  Widget _buildInfoBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.blue),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Your activity level affects your daily calorie needs',
              style: TextStyle(
                color: Colors.blue[800],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelCard(Map<String, dynamic> level) {
    bool isSelected = selectedLevel == level['title'];
    return GestureDetector(
      onTap: () => setState(() => selectedLevel = level['title']!),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFDECEA) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? const Color(0xFFB71C1C) : Colors.grey[200]!,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              level['icon'] as IconData,
              color: isSelected ? const Color(0xFFB71C1C) : Colors.grey,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  level['title']!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: isSelected ? const Color(0xFFB71C1C) : Colors.black,
                  ),
                ),
                Text(
                  level['desc']!,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: Color(0xFFB71C1C)),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityChip(Map<String, String> act) {
    bool isSelected = selectedActivities.contains(act['name']);
    return FilterChip(
      label: Text('${act['emoji']} ${act['name']}'),
      selected: isSelected,
      onSelected: (val) {
        setState(() {
          val
              ? selectedActivities.add(act['name']!)
              : selectedActivities.remove(act['name']);
        });
      },
      selectedColor: const Color(0xFFE3F2FD),
      checkmarkColor: Colors.blue,
      shape: StadiumBorder(
        side: BorderSide(color: isSelected ? Colors.blue : Colors.grey[300]!),
      ),
      backgroundColor: Colors.white,
      labelStyle: TextStyle(color: isSelected ? Colors.blue : Colors.black87),
    );
  }

  Widget _buildNextButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DietPlanSetup()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFB71C1C),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Next', style: TextStyle(fontSize: 18, color: Colors.white)),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, color: Colors.white, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class DietPlanSetup extends StatefulWidget {
  const DietPlanSetup({super.key});

  @override
  State<DietPlanSetup> createState() => _DietPlanSetupState();
}

class _DietPlanSetupState extends State<DietPlanSetup> {
  String selectedDiet = 'Non-vegetarian';

  final List<Map<String, String>> dietOptions = [
    {
      'title': 'Vegetarian',
      'subtitle': 'No meat, includes dairy & eggs',
      'icon': '🥬',
    },
    {
      'title': 'Non-vegetarian',
      'subtitle': 'Includes all food groups',
      'icon': '🍗',
    },
    {'title': 'Vegan', 'subtitle': 'Plant-based only', 'icon': '🌱'},
    {
      'title': 'Pescatarian',
      'subtitle': 'Fish allowed, no other meat',
      'icon': '🐟',
    },
    {'title': 'Eggetarian', 'subtitle': 'Vegetarian with eggs', 'icon': '🥚'},
    {'title': 'Halal', 'subtitle': 'Islamic dietary laws', 'icon': '🕌'},
    {'title': 'Kosher', 'subtitle': 'Jewish dietary laws', 'icon': '🕎'},
    {
      'title': 'Jain',
      'subtitle': 'No root vegetables, strict vegetarian',
      'icon': '🙏',
    },
    {'title': 'High Protein', 'subtitle': 'Protein-rich meals', 'icon': '💪'},
    {'title': 'Keto', 'subtitle': 'Low-carb, high-fat', 'icon': '🥑'},
    {
      'title': 'Diabetic-friendly',
      'subtitle': 'Low sugar, balanced carbs',
      'icon': '🩺',
    },
    {'title': 'Gluten-free', 'subtitle': 'No wheat or gluten', 'icon': '🌾'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          'Health Profile Setup',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Step 8 of 12',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        '66%',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: 0.66,
                    backgroundColor: Colors.grey[200],
                    color: Colors.red[900],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  const SizedBox(height: 30),

                  Icon(Icons.restaurant, size: 50, color: Colors.red[900]),
                  const SizedBox(height: 20),

                  const Text(
                    'What is your diet plan?',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Select the diet that best matches your preferences.',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDECEA),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.swap_vert, size: 18, color: Colors.red[900]),
                        const SizedBox(width: 8),
                        Text(
                          'Scroll to see all 12 diet options',
                          style: TextStyle(
                            color: Colors.red[900],
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.85,
                        ),
                    itemCount: dietOptions.length,
                    itemBuilder: (context, index) {
                      final option = dietOptions[index];
                      return DietCard(
                        title: option['title']!,
                        subtitle: option['subtitle']!,
                        icon: option['icon']!,
                        isSelected: selectedDiet == option['title'],
                        onTap: () =>
                            setState(() => selectedDiet = option['title']!),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AllergySetupScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB71C1C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Next',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DietCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;

  const DietCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFDECEA) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? const Color(0xFFB71C1C) : Colors.grey[200]!,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isSelected ? const Color(0xFFB71C1C) : Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: isSelected
                    ? const Color(0xFFB71C1C).withOpacity(0.7)
                    : Colors.grey[500],
              ),
            ),
            if (isSelected) ...[
              const SizedBox(height: 8),
              const Icon(
                Icons.check_circle,
                size: 18,
                color: Color(0xFFB71C1C),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AllergySetupScreen extends StatefulWidget {
  const AllergySetupScreen({super.key});

  @override
  State<AllergySetupScreen> createState() => _AllergySetupScreenState();
}

class _AllergySetupScreenState extends State<AllergySetupScreen> {
  final Set<String> selectedAllergies = {
    'Peanuts',
    'Tree Nuts',
    'Milk',
    'Eggs',
    'Wheat/Gluten',
    'Soy',
    'Fish',
    'Mustard',
  };
  final Set<String> selectedDislikes = {
    'Mushrooms',
    'Olives',
    'Onions',
    'Garlic',
    'Cilantro',
    'Tomatoes',
    'Eggplant',
    'Seafood',
  };

  final List<String> allergies = [
    'Peanuts',
    'Tree Nuts',
    'Milk',
    'Eggs',
    'Wheat/Gluten',
    'Soy',
    'Fish',
    'Shellfish',
    'Sesame',
    'Mustard',
  ];

  final List<String> dislikes = [
    'Mushrooms',
    'Olives',
    'Onions',
    'Garlic',
    'Cilantro',
    'Tomatoes',
    'Peppers',
    'Eggplant',
    'Seafood',
    'Spicy Food',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          'Health Profile Setup',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(9, 0.75, "75%"),
                  const SizedBox(height: 30),

                  const Icon(
                    Icons.warning_amber_rounded,
                    size: 60,
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 20),

                  const Text(
                    'Any allergies or dislikes?',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Help us avoid ingredients you can't or don't want to eat.",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 30),

                  _buildSectionTitle("⚠️ Critical Allergies", Colors.red[900]!),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 10,
                    children: allergies
                        .map(
                          (name) => _buildSelectionChip(
                            name,
                            selectedAllergies,
                            const Color(0xFFB71C1C),
                            const Color(0xFFFDECEA),
                          ),
                        )
                        .toList(),
                  ),

                  const SizedBox(height: 30),

                  _buildSectionTitle("👎 Food Dislikes", Colors.orange[800]!),
                  Text(
                    "Optional - Foods you prefer to avoid",
                    style: TextStyle(color: Colors.grey[500], fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 10,
                    children: dislikes
                        .map(
                          (name) => _buildSelectionChip(
                            name,
                            selectedDislikes,
                            const Color(0xFFE65100),
                            const Color(0xFFFFF3E0),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          _buildNextButton(),
        ],
      ),
    );
  }

  Widget _buildHeader(int step, double progress, String percent) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Step $step of 12',
              style: const TextStyle(color: Colors.grey),
            ),
            Text(
              percent,
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[200],
          color: Colors.red[900],
          borderRadius: BorderRadius.circular(10),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
    );
  }

  Widget _buildSelectionChip(
    String name,
    Set<String> selectionSet,
    Color activeColor,
    Color activeBg,
  ) {
    bool isSelected = selectionSet.contains(name);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectionSet.remove(name);
          } else {
            selectionSet.add(name);
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? activeBg : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? activeColor : Colors.grey[300]!,
            width: 1.5,
          ),
        ),
        child: Text(
          name,
          style: TextStyle(
            color: isSelected ? activeColor : Colors.grey[700],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PreferencesBudgetScreen(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFB71C1C),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Next', style: TextStyle(fontSize: 18, color: Colors.white)),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward, color: Colors.white, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class PreferencesBudgetScreen extends StatefulWidget {
  const PreferencesBudgetScreen({super.key});

  @override
  State<PreferencesBudgetScreen> createState() =>
      _PreferencesBudgetScreenState();
}

class _PreferencesBudgetScreenState extends State<PreferencesBudgetScreen> {
  final Set<String> selectedCuisines = {'Indian', 'Chinese', 'Italian'};
  final Set<String> selectedGoals = {
    'Muscle Gain',
    'Heart Health',
    'Brain Health',
    'Skin Health',
  };
  String cookTime = '15-30 mins';
  String kitchenSetup = 'Full Kitchen';
  String heavyMeal = 'Dinner';
  final Set<int> vegDays = {1, 2, 4};
  double budget = 5000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFE),
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Colors.black54),
        title: const Text(
          'Health Profile Setup',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  _buildProgressHeader(),
                  const SizedBox(height: 25),
                  const Center(
                    child: Icon(
                      Icons.settings,
                      size: 60,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Preferences & Budget",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const _SubTitle(text: "Help us personalize your meal plans."),
                  const SizedBox(height: 15),
                  _buildPromoBox(),

                  _buildSectionTitle("Preferred Cuisines"),
                  _buildCuisineSelector(),

                  _buildSectionTitle("Health Goals (Optional)"),
                  _buildGoalsSelector(),

                  _buildSectionTitle("Cooking Time Preference"),
                  _buildTimeSelector(),

                  _buildSectionTitle("Kitchen Setup"),
                  _buildKitchenSelector(),

                  _buildSectionTitle(
                    "When Do You Prefer Your Main Heavy Meal?",
                  ),
                  _buildMealSelector(),

                  _buildSectionTitle("Vegetarian Days (Optional)"),
                  const _SubTitle(text: "Select days for vegetarian meals"),
                  const SizedBox(height: 12),
                  _buildDayPicker(),

                  _buildSectionTitle("💵 Weekly Budget"),
                  _buildBudgetSection(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildProgressHeader() {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Step 10 of 12', style: TextStyle(color: Colors.grey)),
            Text(
              '83%',
              style: TextStyle(
                color: Color(0xFFB71C1C),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: 0.83,
            minHeight: 8,
            backgroundColor: Colors.grey[200],
            color: const Color(0xFFB71C1C),
          ),
        ),
      ],
    );
  }

  Widget _buildPromoBox() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          Icon(Icons.wb_sunny_outlined, color: Colors.orangeAccent, size: 22),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              "Meal planning can save you up to 30% on grocery bills!",
              style: TextStyle(
                color: Colors.purple,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCuisineSelector() {
    final cuisines = [
      'Indian',
      'Chinese',
      'Italian',
      'Japanese',
      'Mexican',
      'Thai',
      'Korean',
    ];
    return Wrap(
      spacing: 8,
      runSpacing: 10,
      children: cuisines.map((name) {
        final isSelected = selectedCuisines.contains(name);
        return ChoiceChip(
          label: Text(name),
          selected: isSelected,
          onSelected: (val) => setState(
            () => val
                ? selectedCuisines.add(name)
                : selectedCuisines.remove(name),
          ),
          backgroundColor: Colors.white,
          selectedColor: const Color(0xFFFDECEA),
          labelStyle: TextStyle(
            color: isSelected ? const Color(0xFFB71C1C) : Colors.black54,
          ),
          shape: StadiumBorder(
            side: BorderSide(
              color: isSelected ? const Color(0xFFB71C1C) : Colors.grey[300]!,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildGoalsSelector() {
    final goals = {
      '💪 Muscle Gain': 'Muscle Gain',
      '❤️ Heart Health': 'Heart Health',
      '🧠 Brain Health': 'Brain Health',
      '✨ Skin Health': 'Skin Health',
    };
    return Wrap(
      spacing: 8,
      runSpacing: 10,
      children: goals.entries.map((e) {
        final isSelected = selectedGoals.contains(e.value);
        return ChoiceChip(
          label: Text(e.key),
          selected: isSelected,
          onSelected: (val) => setState(
            () => val
                ? selectedGoals.add(e.value)
                : selectedGoals.remove(e.value),
          ),
          backgroundColor: Colors.white,
          selectedColor: const Color(0xFFE0F2F1),
          labelStyle: TextStyle(
            color: isSelected ? const Color(0xFF00796B) : Colors.black54,
          ),
          shape: StadiumBorder(
            side: BorderSide(
              color: isSelected ? const Color(0xFF00796B) : Colors.grey[300]!,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTimeSelector() {
    return Row(
      children: [
        _buildSmallChoiceCard(
          "⚡ 15-30 mins",
          "Quick & Easy",
          cookTime == '15-30 mins',
          () => setState(() => cookTime = '15-30 mins'),
        ),
        const SizedBox(width: 10),
        _buildSmallChoiceCard(
          "🍲 45-60 mins",
          "Moderate Time",
          cookTime == '45-60 mins',
          () => setState(() => cookTime = '45-60 mins'),
        ),
      ],
    );
  }

  Widget _buildDayPicker() {
    final days = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(7, (i) {
        final isSelected = vegDays.contains(i);
        return GestureDetector(
          onTap: () =>
              setState(() => isSelected ? vegDays.remove(i) : vegDays.add(i)),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: isSelected
                ? const Color(0xFF00A676)
                : Colors.grey[100],
            child: Text(
              days[i],
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black54,
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildBudgetSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            "Weekly Budget:",
            style: TextStyle(color: Colors.green[800], fontSize: 16),
          ),
          Text(
            "₹${budget.toInt()}.00",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.green[800],
            ),
          ),
          Slider(
            value: budget,
            min: 1000,
            max: 10000,
            activeColor: const Color(0xFF00A676),
            onChanged: (val) => setState(() => budget = val),
          ),
          Text(
            "≈ ₹${(budget / 21).toStringAsFixed(0)} per meal average",
            style: const TextStyle(color: Colors.black45),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Skip",
              style: TextStyle(color: Colors.black45, fontSize: 16),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CookingLevelScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB71C1C),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Next →",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildSmallChoiceCard(
    String title,
    String sub,
    bool active,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: active ? const Color(0xFFFDECEA) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: active ? const Color(0xFFB71C1C) : Colors.grey[200]!,
            ),
          ),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: active ? const Color(0xFFB71C1C) : Colors.black87,
                ),
              ),
              Text(
                sub,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMealSelector() => Row(
    children: [
      _buildSmallChoiceCard(
        "🌅 Breakfast",
        "Heavy morning",
        heavyMeal == 'Breakfast',
        () => setState(() => heavyMeal = 'Breakfast'),
      ),
      const SizedBox(width: 8),
      _buildSmallChoiceCard(
        "☀️ Lunch",
        "Main midday",
        heavyMeal == 'Lunch',
        () => setState(() => heavyMeal = 'Lunch'),
      ),
      const SizedBox(width: 8),
      _buildSmallChoiceCard(
        "🌙 Dinner",
        "Substantial",
        heavyMeal == 'Dinner',
        () => setState(() => heavyMeal = 'Dinner'),
      ),
    ],
  );

  Widget _buildKitchenSelector() => Row(
    children: [
      _buildSmallChoiceCard(
        "🔥 Air Fryer",
        "Modern",
        kitchenSetup == 'Air Fryer',
        () => setState(() => kitchenSetup = 'Air Fryer'),
      ),
      const SizedBox(width: 8),
      _buildSmallChoiceCard(
        "🍚 Rice Cooker",
        "Simple",
        kitchenSetup == 'Rice Cooker',
        () => setState(() => kitchenSetup = 'Rice Cooker'),
      ),
      const SizedBox(width: 8),
      _buildSmallChoiceCard(
        "👨‍🍳 Full Kitchen",
        "All Equipment",
        kitchenSetup == 'Full Kitchen',
        () => setState(() => kitchenSetup = 'Full Kitchen'),
      ),
    ],
  );
}

class _SubTitle extends StatelessWidget {
  final String text;
  const _SubTitle({required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.chat_bubble_outline, size: 14, color: Colors.grey),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(color: Colors.grey, fontSize: 13)),
      ],
    );
  }
}

class CookingLevelScreen extends StatefulWidget {
  const CookingLevelScreen({super.key});

  @override
  State<CookingLevelScreen> createState() => _CookingLevelScreenState();
}

class _CookingLevelScreenState extends State<CookingLevelScreen> {
  String selectedLevel = 'Me Gordon Ramsay';

  final List<Map<String, dynamic>> levels = [
    {
      'title': 'Me No Cooking',
      'emoji': '🥚',
      'desc': 'I can boil water... sometimes',
      'skills': 'You can make: Toast, instant noodles, cereal',
    },
    {
      'title': 'Me Makes Noodles',
      'emoji': '🍜',
      'desc': 'I follow recipes pretty well',
      'skills': 'You can make: Pasta, stir-fries, simple curries',
    },
    {
      'title': 'Me Cooks Edible Elements',
      'emoji': '👨‍🍳',
      'desc': 'I experiment and rarely mess up',
      'skills': 'You can make: Multi-course meals, baking, meal prep',
    },
    {
      'title': 'Me Gordon Ramsay',
      'emoji': '⭐',
      'desc': 'WHERE IS THE LAMB SAUCE?!',
      'skills': 'You can make: Michelin-worthy, complex techniques',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Colors.black54),
        title: const Text(
          'Health Profile Setup',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildProgressHeader(),
                  const SizedBox(height: 30),
                  const Text('🍳', style: TextStyle(fontSize: 50)),
                  const SizedBox(height: 10),
                  const Text(
                    "Cooking level",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  _buildChatSubtitle("How good are you in the kitchen?"),
                  const SizedBox(height: 20),
                  _buildPurpleTipBox(),
                  const SizedBox(height: 30),
                  const Icon(Icons.search, size: 40, color: Colors.black87),
                  const SizedBox(height: 10),
                  const Text(
                    "What's Your Cooking Level?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Be honest! We'll match recipes to your skill level",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),

                  ...levels.map((level) => _buildCookingCard(level)).toList(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          _buildStickyBottomBar(),
        ],
      ),
    );
  }

  Widget _buildProgressHeader() {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Step 11 of 12', style: TextStyle(color: Colors.grey)),
            Text(
              '91%',
              style: TextStyle(
                color: Color(0xFFB71C1C),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: 0.91,
            minHeight: 6,
            backgroundColor: Colors.grey[200],
            color: const Color(0xFFB71C1C),
          ),
        ),
      ],
    );
  }

  Widget _buildPurpleTipBox() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          Text('✨ 🧂', style: TextStyle(fontSize: 18)),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              "Salt brings out flavor. If food tastes 'flat', it probably needs salt!",
              style: TextStyle(
                color: Colors.purple,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCookingCard(Map<String, dynamic> level) {
    bool isSelected = selectedLevel == level['title'];
    return GestureDetector(
      onTap: () => setState(() => selectedLevel = level['title']),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFDECEA) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFFB71C1C) : Colors.grey[200]!,
            width: 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(level['emoji'], style: const TextStyle(fontSize: 22)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    level['title'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? const Color(0xFFB71C1C)
                          : Colors.black87,
                    ),
                  ),
                ),
                if (isSelected)
                  const Icon(Icons.check_circle, color: Color(0xFFB71C1C)),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              level['desc'],
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFFB71C1C).withOpacity(0.7)
                    : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                level['skills'],
                style: const TextStyle(
                  color: Color(0xFF1976D2),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStickyBottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        children: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Skip",
              style: TextStyle(color: Colors.black45, fontSize: 16),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HealthPlanSummaryScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB71C1C),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Next →",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatSubtitle(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.chat_bubble_outline, size: 16, color: Colors.grey),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

class HealthPlanSummaryScreen extends StatelessWidget {
  const HealthPlanSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: Colors.black54),
        title: const Text(
          'Health Profile Setup',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProgressHeader(),
                  const SizedBox(height: 30),
                  const Icon(
                    Icons.description,
                    size: 50,
                    color: Color(0xFFB71C1C),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Your Personalized Plan",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Here's what we calculated based on your profile.",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(height: 25),

                  _buildMetricsGradientCard(),
                  const SizedBox(height: 20),

                  _buildSummaryCard(
                    color: const Color(0xFFE3F2FD),
                    icon: Icons.fitness_center,
                    iconColor: Colors.blue,
                    label: "Protein Target",
                    value: "112g per day",
                  ),
                  const SizedBox(height: 16),

                  _buildSummaryCard(
                    color: const Color(0xFFE8F5E9),
                    icon: Icons.flag,
                    iconColor: Colors.green,
                    label: "Your Goal",
                    value: "Maintain Weight",
                    subValue: "1.0 kg per week",
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: _buildSmallStatusBox("Diet Plan", "halal"),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildSmallStatusBox("Activity", "Very Active"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  _buildDetailedInfoBox(),
                  const SizedBox(height: 20),

                  _buildInfoTip(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          _buildCompleteButton(),
        ],
      ),
    );
  }

  Widget _buildProgressHeader() {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Step 12 of 12', style: TextStyle(color: Colors.grey)),
            Text(
              '100%',
              style: TextStyle(
                color: Color(0xFFB71C1C),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: const LinearProgressIndicator(
            value: 1.0,
            minHeight: 6,
            backgroundColor: Color(0xFFB71C1C),
            color: Color(0xFFB71C1C),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricsGradientCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFF7043), Color(0xFFD84315)],
        ),
      ),
      child: Column(
        children: [
          const Text(
            "Your Health Metrics",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          _buildMetricGrid(),
        ],
      ),
    );
  }

  Widget _buildMetricGrid() {
    return Column(
      children: [
        Row(
          children: [
            _buildMetricItem("BMI", "7000.0", "Obese"),
            Container(width: 1, height: 40, color: Colors.white24),
            _buildMetricItem("BMR", "509", "calories/day"),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Divider(color: Colors.white24),
        ),
        Row(
          children: [
            _buildMetricItem("TDEE", "878", "calories/day"),
            Container(width: 1, height: 40, color: Colors.white24),
            _buildMetricItem("Daily Goal", "879", "calories"),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricItem(String label, String value, String subText) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subText,
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required Color color,
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    String? subValue,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 30),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: iconColor.withOpacity(0.7),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  color: iconColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (subValue != null)
                Text(
                  subValue,
                  style: TextStyle(
                    color: iconColor.withOpacity(0.6),
                    fontSize: 13,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallStatusBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedInfoBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E5F5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.restaurant_menu, color: Colors.purple, size: 20),
              SizedBox(width: 8),
              Text(
                "Cuisines:",
                style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Text(
            "• Indian  • Chinese  • Italian",
            style: TextStyle(color: Colors.purple),
          ),
          const SizedBox(height: 15),
          const Row(
            children: [
              Icon(Icons.warning, color: Colors.red, size: 20),
              SizedBox(width: 8),
              Text(
                "Allergies:",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            "• Soy • Tree Nuts • Wheat/Gluten • Peanuts\n• Milk • Fish • Mustard • Eggs",
            style: TextStyle(color: Colors.red[900]),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTip() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          Icon(Icons.info_outline, color: Colors.blue),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Tap "Complete Setup" to save your profile and start generating personalized meal plans!',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompleteButton() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.white,
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFB71C1C),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            "Complete Setup",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
