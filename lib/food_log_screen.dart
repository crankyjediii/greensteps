import 'package:flutter/material.dart';

class FoodLogScreen extends StatefulWidget {
  const FoodLogScreen({super.key});

  @override
  State<FoodLogScreen> createState() => _FoodLogScreenState();
}

class _FoodLogScreenState extends State<FoodLogScreen> {
  final TextEditingController _wasteController = TextEditingController();
  List<double> wasteHistory = [];
  double totalWaste = 0.0;

  void _addWaste() {
    final waste = double.tryParse(_wasteController.text);
    if (waste != null && waste > 0) {
      setState(() {
        wasteHistory.add(waste);
        totalWaste += waste;
        _wasteController.clear();
      });
    }
  }

  // Dummy data for Impact Tracker
  final List<Map<String, dynamic>> impactData = [
    {
      'title': 'Carbon Saved',
      'amount': 50, // kg
      'goal': 100, // kg goal
      'unit': 'kg CO₂',
    },
    {
      'title': 'Food Waste Avoided',
      'amount': 20, // lbs
      'goal': 50, // lbs goal
      'unit': 'lbs',
    },
    {
      'title': 'Water Saved',
      'amount': 500, // liters
      'goal': 1000, // liters goal
      'unit': 'liters',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Log Today's Food Waste Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      "Log Today's Food Waste",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _wasteController,
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            decoration: InputDecoration(
                              hintText: "e.g. 1.5 lbs",
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton.icon(
                          onPressed: _addWaste,
                          icon: const Icon(Icons.add),
                          label: const Text("Add"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade700,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Total Waste Logged Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      "Total Waste Logged: ${totalWaste.toStringAsFixed(2)} lbs",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    const Divider(),
                    const Text(
                      "💡 Tip: Plan meals and store food properly to reduce waste!",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            
            // Waste History List
            Expanded(
              child: wasteHistory.isEmpty
                  ? const Center(child: Text("No entries yet!", style: TextStyle(fontSize: 16)))
                  : ListView.builder(
                      itemCount: wasteHistory.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            leading: const Icon(Icons.delete_outline_rounded, color: Colors.red),
                            title: Text("Entry ${index + 1}"),
                            trailing: Text("${wasteHistory[index].toStringAsFixed(2)} lbs"),
                          ),
                        );
                      },
                    ),
            ),
            // Impact Tracker Section
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                '🌍 Impact Tracker',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            // List of impact data (carbon, water, food waste)
            ...impactData.map(_buildImpactCard).toList(),

            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }

  // Widget for displaying an impact card
  Widget _buildImpactCard(Map<String, dynamic> impact) {
    double progress = impact['amount'] / impact['goal'];

    return Card(
      child: ListTile(
        title: Text(
          impact['title'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${impact['amount']} / ${impact['goal']} ${impact['unit']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              color: Colors.green,
              backgroundColor: Colors.grey.shade300,
            ),
          ],
        ),
      ),
    );
  }
}
