import 'package:flutter/material.dart';
import 'expense.dart';
import 'add_expense_screen.dart';
import 'budget_generator.dart';
import 'savings_tracker.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Expense> _expenses = [
    Expense(id: 'e1', title: 'Lunch', amount: 15.0, date: DateTime.now(), category: 'Food'),
    Expense(id: 'e2', title: 'Bus Fare', amount: 2.5, date: DateTime.now(), category: 'Transport'),
    Expense(id: 'e3', title: 'Flutter Book', amount: 50.0, date: DateTime.now(), category: 'Books'),
  ];

  void _addExpense() async {
    final newExpense = await Navigator.push<Expense>(
      context,
      MaterialPageRoute(builder: (context) => const AddExpenseScreen()),
    );

    if (newExpense != null) {
      setState(() {
        _expenses.add(newExpense);
      });
    }
  }

  void _deleteExpense(String id) {
    setState(() {
      _expenses.removeWhere((expense) => expense.id == id);
    });
  }

  double get _totalSpent {
    return _expenses.fold(0.0, (sum, e) => sum + e.amount);
  }

  Icon _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return const Icon(Icons.restaurant, color: Colors.white);
      case 'transport':
        return const Icon(Icons.directions_bus, color: Colors.white);
      case 'books':
        return const Icon(Icons.book, color: Colors.white);
      case 'entertainment':
        return const Icon(Icons.movie, color: Colors.white);
      default:
        return const Icon(Icons.money, color: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: Container(
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
            const SizedBox(height: 16),
            Center(
              child: Text(
                'Total Spent: Ksh ${_totalSpent.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Action buttons for budgeting and savings
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _featureCard(
                    icon: Icons.pie_chart,
                    label: 'Create Budget',
                    color: Colors.orangeAccent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BudgetGeneratorScreen(),
                        ),
                      );
                    },
                  ),
                  _featureCard(
                    icon: Icons.savings,
                    label: 'Track Savings',
                    color: Colors.greenAccent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SavingsTrackerScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Your Expenses',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Expense list
            Expanded(
              child: ListView.builder(
                itemCount: _expenses.length,
                itemBuilder: (context, index) {
                  final expense = _expenses[index];
                  return Dismissible(
                    key: Key(expense.id),
                    direction: DismissDirection.endToStart,
                    onDismissed: (_) => _deleteExpense(expense.id),
                    background: Container(
                      color: Colors.red,
                      padding: const EdgeInsets.only(right: 20),
                      alignment: Alignment.centerRight,
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: Card(
                      color: Colors.white.withOpacity(0.2),
                      margin: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      child: ListTile(
                        leading: _getCategoryIcon(expense.category),
                        title: Text(
                          expense.title,
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          expense.category,
                          style: const TextStyle(color: Colors.white70),
                        ),
                        trailing: Text(
                          'Ksh ${expense.amount.toStringAsFixed(2)}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addExpense,
        backgroundColor: Colors.tealAccent[700],
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _featureCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color.withOpacity(0.9),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Column(
            children: [
              Icon(icon, size: 30, color: Colors.white),
              const SizedBox(height: 6),
              Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
