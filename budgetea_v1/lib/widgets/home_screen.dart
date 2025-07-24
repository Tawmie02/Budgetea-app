import 'package:flutter/material.dart';
import 'package:budgetea_v1/screens/dashboard_screen.dart';
import 'package:budgetea_v1/screens/budget_generator.dart';
import 'package:budgetea_v1/screens/savings_tracker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    BudgetGeneratorScreen(),
    SavingsTrackerScreen(),
  ];

  final List<String> _titles = const [
    'My Dashboard',
    'Budget Generator',
    'Savings Tracker',
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
final List<BottomNavigationBarItem> _navItems = const [
  BottomNavigationBarItem(
    icon: Icon(Icons.dashboard_outlined),
    activeIcon: Icon(Icons.dashboard, color: Colors.purple),
    label: 'Dashboard',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.pie_chart_outline),
    activeIcon: Icon(Icons.pie_chart, color: Colors.purple),
    label: 'Budget',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.savings_outlined),
    activeIcon: Icon(Icons.savings, color: Colors.purple),
    label: 'Savings',
  ),
];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        items: _navItems,
      ),
    );
  }
}
