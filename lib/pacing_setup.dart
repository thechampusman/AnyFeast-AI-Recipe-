import 'package:flutter/material.dart';

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
                onPressed: () {},
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
