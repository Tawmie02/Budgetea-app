import 'package:flutter/material.dart';

class SavingsTrackerScreen extends StatefulWidget {
  const SavingsTrackerScreen({super.key});

  @override
  State<SavingsTrackerScreen> createState() => _SavingsTrackerScreenState();
}

class _SavingsTrackerScreenState extends State<SavingsTrackerScreen> {
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _savedController = TextEditingController();

  double? _goalAmount;
  double _savedAmount = 0.0;

  void _setGoal() {
    final goal = double.tryParse(_goalController.text);
    if (goal == null || goal <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid goal')),
      );
      return;
    }

    setState(() {
      _goalAmount = goal;
      _savedAmount = 0.0;
      _goalController.clear();
    });
  }

  void _addSavings() {
    final saved = double.tryParse(_savedController.text);
    if (saved == null || saved <= 0 || _goalAmount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid amount & set a goal')),
      );
      return;
    }

    setState(() {
      _savedAmount += saved;
      if (_savedAmount > _goalAmount!) {
        _savedAmount = _goalAmount!;
      }
      _savedController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_goalAmount != null && _goalAmount! > 0)
        ? (_savedAmount / _goalAmount!).clamp(0.0, 1.0)
        : 0.0;

    final goalReached = _goalAmount != null && _savedAmount >= _goalAmount!;

    return Scaffold(
    
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.deepPurple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.savings, size: 50, color: Colors.white),
            const SizedBox(height: 12),
            const Text(
              'Track your savings progress toward your financial goals 💰',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Set goal card
            Card(
              color: Colors.white.withOpacity(0.15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'Set a Savings Goal',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _goalController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'e.g. 5000',
                              hintStyle: const TextStyle(color: Colors.white70),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: _setGoal,
                          child: const Text('Set'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent[700],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Progress section
            if (_goalAmount != null)
              Card(
                color: Colors.white.withOpacity(0.2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('🎯 Goal: Ksh $_goalAmount',
                          style: const TextStyle(color: Colors.white, fontSize: 16)),
                      Text('💵 Saved: Ksh $_savedAmount',
                          style: const TextStyle(color: Colors.white70, fontSize: 15)),
                      const SizedBox(height: 12),
                      LinearProgressIndicator(
                        value: progress,
                        minHeight: 10,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.greenAccent),
                      ),
                      const SizedBox(height: 10),
                      if (goalReached)
                        const Text(
                          '🎉 Congratulations! Goal Achieved!',
                          style: TextStyle(
                              color: Colors.yellowAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 20),

            if (_goalAmount != null)
              Card(
                color: Colors.white.withOpacity(0.15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Text(
                        'Log Savings',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _savedController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'e.g. 300',
                                hintStyle: const TextStyle(color: Colors.white70),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.2),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: _addSavings,
                            child: const Text('Add'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.tealAccent[700],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),

            const Spacer(),

            const Center(
              child: Text(
                '“A penny saved is a penny earned.” 🪙',
                style: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
      ),
    );
  }
}
