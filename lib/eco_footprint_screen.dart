import 'package:flutter/material.dart';

class EcoFootprintScreen extends StatefulWidget {
  const EcoFootprintScreen({super.key});

  @override
  State<EcoFootprintScreen> createState() => _EcoFootprintScreenState();
}

class _EcoFootprintScreenState extends State<EcoFootprintScreen> {
  double milesDriven = 0;
  double electricityUsed = 0;
  double foodWaste = 0;
  double calculatedFootprint = 0;

  void calculateFootprint() {
    // Basic multipliers (could be improved with real data later)
    double transport = milesDriven * 0.411; // kg CO2 per mile (car)
    double electricity = electricityUsed * 0.85; // kg CO2 per kWh
    double food = foodWaste * 1.9; // kg CO2 per lb food wasted

    setState(() {
      calculatedFootprint = transport + electricity + food;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("Input today's usage", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

            const SizedBox(height: 16),
            _buildSliderCard("Miles Driven", milesDriven, 0, 100, (val) {
              setState(() => milesDriven = val);
            }),

            _buildSliderCard("Electricity (kWh)", electricityUsed, 0, 50, (val) {
              setState(() => electricityUsed = val);
            }),

            _buildSliderCard("Food Waste (lbs)", foodWaste, 0, 20, (val) {
              setState(() => foodWaste = val);
            }),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateFootprint,
              child: const Text("Calculate"),
            ),

            const SizedBox(height: 20),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text("Your Estimated Footprint Today", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(
                      "${calculatedFootprint.toStringAsFixed(2)} kg CO₂",
                      style: const TextStyle(fontSize: 24, color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliderCard(String label, double value, double min, double max, Function(double) onChanged) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$label: ${value.toStringAsFixed(1)}", style: const TextStyle(fontWeight: FontWeight.bold)),
            Slider(
              value: value,
              min: min,
              max: max,
              divisions: 100,
              label: value.toStringAsFixed(1),
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
