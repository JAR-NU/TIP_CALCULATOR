
import 'package:flutter/material.dart';

void main() {
  runApp(const TipApp());
}

class TipApp extends StatelessWidget {
  const TipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tip Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const TipPage(),
    );
  }
}

// Parse bill amount
double? parseBill(String input) {
  return double.tryParse(input.trim());
}

// Calculate tip and total
({double tip, double total}) computeTip(
    double bill, int percent) {
  final tip = bill * percent / 100;

  return (
    tip: tip,
    total: bill + tip,
  );
}

class TipPage extends StatefulWidget {
  const TipPage({super.key});

  @override
  State<TipPage> createState() => _TipPageState();
}

class _TipPageState extends State<TipPage> {
  final TextEditingController _billController =
      TextEditingController();

  int _selectedPercent = 15;

  @override
  void dispose() {
    _billController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bill = parseBill(_billController.text);

    final result = bill != null && bill >= 0 && bill.isFinite
        ? computeTip(bill, _selectedPercent)
        : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tip Calculator'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            const Text(
              'Enter Bill Amount',
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: _billController,
              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                hintText: 'Enter amount',
                prefixText: '₱ ',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),

            const SizedBox(height: 25),

            const Text(
              'Select Tip Percentage',
              style: TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 10, label: Text('10%')),
                ButtonSegment(value: 15, label: Text('15%')),
                ButtonSegment(value: 20, label: Text('20%')),
              ],
              selected: {_selectedPercent},
              onSelectionChanged: (selection) {
                setState(() {
                  _selectedPercent = selection.first;
                });
              },
            ),

            const SizedBox(height: 30),

            if (result != null) ...[
              Text(
                'Tip: ₱${result.tip.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 20),
              ),

              const SizedBox(height: 15),

              Text(
                'Total: ₱${result.total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ] else ...[
              const Text(
                'Enter a valid amount',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
