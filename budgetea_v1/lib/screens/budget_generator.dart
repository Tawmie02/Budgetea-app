import 'package:flutter/material.dart';

class BudgetGeneratorScreen extends StatefulWidget {
  const BudgetGeneratorScreen({super.key});

  @override
  State<BudgetGeneratorScreen> createState() => _BudgetGeneratorScreenState();
}

class _BudgetGeneratorScreenState extends State<BudgetGeneratorScreen> {
  final TextEditingController _incomeController = TextEditingController();
  double? needs;
  double? wants;
  double? savings;

  void _generateBudget() {
    final income = double.tryParse(_incomeController.text);
    if (income == null || income <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid income')),
      );
      return;
    }

    setState(() {
      needs = income * 0.5;
      wants = income * 0.3;
      savings = income * 0.2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.calculate, size: 50, color: Colors.white),
            const SizedBox(height: 12),
            const Text(
              'Generate a Smart Budget using 50/30/20 rule',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 20),

            // Income input card
            Card(
              color: Colors.white.withOpacity(0.15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Enter Monthly Income',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _incomeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'e.g. 10000',
                        hintStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: _generateBudget,
                      icon: const Icon(Icons.auto_graph),
                      label: const Text('Generate Budget'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Budget result
            if (needs != null && wants != null && savings != null)
              Card(
                color: Colors.white.withOpacity(0.2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '📊 Budget Breakdown',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text('🧾 Needs (50%): Ksh ${needs!.toStringAsFixed(2)}',
                          style: const TextStyle(color: Colors.white, fontSize: 16)),
                      Text('🎯 Wants (30%): Ksh ${wants!.toStringAsFixed(2)}',
                          style: const TextStyle(color: Colors.white, fontSize: 16)),
                      Text('💰 Savings (20%): Ksh ${savings!.toStringAsFixed(2)}',
                          style: const TextStyle(color: Colors.white, fontSize: 16)),
                    ],
                  ),
                ),
              ),

            const Spacer(),

            const Center(
              child: Text(
                'Plan smarter. Save better. 💡',
                style: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
