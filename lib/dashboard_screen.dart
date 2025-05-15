import 'package:flutter/material.dart';
import 'weekly_chart.dart';
import 'models/daily_carbon_data.dart';

// Dummy data for milestones (replace with actual data as needed)
final List<Map<String, dynamic>> milestones = [
  {
    'title': 'Clean Plate Champion',
    'description': 'Save 10 meals',
    'earned': false,
  },
  {
    'title': 'Water Warrior',
    'description': 'Save 1,000 liters of water',
    'earned': false,
  },
  {
    'title': 'Carbon Crusher',
    'description': 'Avoid 50 kg of CO₂',
    'earned': true,
  },
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<DailyCarbonData> weeklyData = [
      DailyCarbonData(day: 'M', value: 1.5),
      DailyCarbonData(day: 'T', value: 2.0),
      DailyCarbonData(day: 'W', value: 1.8),
      DailyCarbonData(day: 'T', value: 2.3),
      DailyCarbonData(day: 'F', value: 2.1),
      DailyCarbonData(day: 'S', value: 1.7),
      DailyCarbonData(day: 'S', value: 2.5),
    ];

    final double totalCarbon = weeklyData.fold(0, (sum, day) => sum + day.value);
    final double avgCarbon = totalCarbon / weeklyData.length;
    final int foodWasteAvoided = 4; // placeholder, could be dynamic later

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Weekly Carbon Chart
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      "Weekly Carbon Output",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    WeeklyChart(data: weeklyData),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Key Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _StatCard(label: "Total Saved", value: "${totalCarbon.toStringAsFixed(1)} kg"),
                _StatCard(label: "Food Waste Avoided", value: "$foodWasteAvoided lbs"),
                _StatCard(label: "Daily Avg", value: "${avgCarbon.toStringAsFixed(1)} kg"),
              ],
            ),
            const SizedBox(height: 20),

            // Tip of the week
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "🌱 Daily Eco Tip",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text("Reduce food waste by meal prepping and buying only what you need."),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Milestones Section
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                '🏆 Milestones',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            // List of milestones
            ...milestones.map(_buildMilestoneCard).toList(),
          ],
        ),
      ),
    );
  }

  // Widget for displaying a milestone card
  Widget _buildMilestoneCard(Map<String, dynamic> milestone) {
    return Card(
      color: milestone['earned'] ? Colors.green[100] : Colors.grey[300],
      child: ListTile(
        leading: Icon(
          milestone['earned'] ? Icons.emoji_events : Icons.lock,
          color: milestone['earned'] ? Colors.green[800] : Colors.grey[600],
        ),
        title: Text(
          milestone['title'],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: milestone['earned'] ? Colors.green[900] : Colors.grey[700],
          ),
        ),
        subtitle: Text(
          milestone['description'],
          style: TextStyle(
            color: milestone['earned'] ? Colors.green[700] : Colors.grey[600],
          ),
        ),
        trailing: milestone['earned']
            ? const Icon(Icons.check_circle, color: Colors.green)
            : null,
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: Colors.green.shade50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Column(
            children: [
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                value,
                style: const TextStyle(fontSize: 16, color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
