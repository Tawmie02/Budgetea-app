import 'package:flutter/material.dart';
import 'package:student_expenditure_tracker/models/expense.dart';
import 'package:student_expenditure_tracker/screens/add_expense_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Expense> _expenses = [
    Expense(
        id: 'e1',
        title: 'Lunch',
        amount: 15.0,
        date: DateTime.now(),
        category: 'Food'),
    Expense(
        id: 'e2',
        title: 'Bus Fare',
        amount: 2.5,
        date: DateTime.now(),
        category: 'Transport'),
    Expense(
        id: 'e3',
        title: 'Flutter Book',
        amount: 50.0,
        date: DateTime.now(),
        category: 'Books'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          itemCount: _expenses.length,
          itemBuilder: (context, index) {
            final expense = _expenses[index];
            return Card(
              color: Colors.white.withOpacity(0.2),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                title: Text(expense.title,
                    style: const TextStyle(color: Colors.white)),
                subtitle: Text(expense.category,
                    style: const TextStyle(color: Colors.white70)),
                trailing: Text(
                  '\$${expense.amount.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addExpense,
        child: const Icon(Icons.add),
      ),
    );
  }
}
