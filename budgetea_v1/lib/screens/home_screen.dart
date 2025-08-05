import 'package:flutter/material.dart';
import 'package:budgetea_v1/theme/theme.dart';

// Import your feature screens
import 'dashboard_screen.dart';
import 'budget_generator.dart';
import 'savings_tracker.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = lightColorScheme.primary;
    final onPrimary = lightColorScheme.onPrimary;
    final surface = lightColorScheme.surface;
    final onSurface = lightColorScheme.onSurface;

    return Scaffold(
      backgroundColor: surface,
      body: CustomScrollView(
        slivers: [
          // ===== HERO SECTION =====
          SliverToBoxAdapter(
            child: _HeroSection(
              primary: primary,
              onPrimary: onPrimary,
            ),
          ),

          // ===== STATS GRID =====
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            sliver: SliverToBoxAdapter(
              child: _StatsGrid(primary: primary, onSurface: onSurface),
            ),
          ),

          // ===== ACTIONS ROW =====
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            sliver: SliverToBoxAdapter(
              child: _ActionsRow(
                primary: primary,
                onSurface: onSurface,
                onOpenDashboard: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DashboardScreen()),
                  );
                },
                onOpenBudget: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const BudgetGeneratorScreen()),
                  );
                },
                onOpenSavings: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SavingsTrackerScreen()),
                  );
                },
                onQuickAddExpense: () {
                  // TODO: Hook to your AddExpense flow
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Quick Add coming soon…')),
                  );
                },
              ),
            ),
          ),

          // ===== RECENT ACTIVITY HEADER =====
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            sliver: SliverToBoxAdapter(
              child: Text(
                'Recent Activity',
                style: TextStyle(
                  color: onSurface.withOpacity(0.9),
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
          ),

          // ===== RECENT ACTIVITY LIST =====
          SliverList.separated(
            itemCount: _mockRecent.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, i) {
              final item = _mockRecent[i];
              return _RecentTile(
                title: item.title,
                subtitle: item.category,
                amount: item.amount,
                icon: item.icon,
                color: primary,
                onSurface: onSurface,
              );
            },
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

// ===== HERO SECTION =====
class _HeroSection extends StatelessWidget {
  const _HeroSection({
    required this.primary,
    required this.onPrimary,
  });

  final Color primary;
  final Color onPrimary;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            primary.withOpacity(0.95),
            primary.withOpacity(0.75),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Subtle radial overlay
          Positioned(
            right: -40,
            top: -40,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: onPrimary.withOpacity(0.06),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.account_balance_wallet_rounded, color: onPrimary, size: 28),
                const SizedBox(height: 8),
                Text(
                  'Welcome back 👋',
                  style: TextStyle(
                    color: onPrimary.withOpacity(0.95),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'My Dashboard',
                  style: TextStyle(
                    color: onPrimary,
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
                const Spacer(),
                Text(
                  'Plan smarter • Spend better • Save more',
                  style: TextStyle(
                    color: onPrimary.withOpacity(0.9),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===== STATS GRID =====
class _StatsGrid extends StatelessWidget {
  const _StatsGrid({
    required this.primary,
    required this.onSurface,
  });

  final Color primary;
  final Color onSurface;

  @override
  Widget build(BuildContext context) {
    final cards = [
      _StatCardData(
        title: 'Total Spent',
        value: 'Ksh 12,450',
        icon: Icons.trending_down_rounded,
      ),
      _StatCardData(
        title: 'This Month',
        value: 'Ksh 3,250',
        icon: Icons.calendar_month_rounded,
      ),
      _StatCardData(
        title: 'Savings',
        value: 'Ksh 5,800',
        icon: Icons.savings_rounded,
      ),
      _StatCardData(
        title: 'Budgets',
        value: '2 Active',
        icon: Icons.pie_chart_rounded,
      ),
    ];

    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cards.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 104,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemBuilder: (_, i) {
        final c = cards[i];
        return _StatCard(
          title: c.title,
          value: c.value,
          icon: c.icon,
          primary: primary,
          onSurface: onSurface,
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.primary,
    required this.onSurface,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color primary;
  final Color onSurface;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: onSurface.withOpacity(0.02),
      elevation: 0,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: onSurface.withOpacity(0.08)),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: primary, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: onSurface.withOpacity(0.7),
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                      )),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      color: onSurface.withOpacity(0.95),
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCardData {
  final String title;
  final String value;
  final IconData icon;
  _StatCardData({required this.title, required this.value, required this.icon});
}

// ===== ACTION BUTTONS =====
class _ActionsRow extends StatelessWidget {
  const _ActionsRow({
    required this.primary,
    required this.onSurface,
    required this.onOpenDashboard,
    required this.onOpenBudget,
    required this.onOpenSavings,
    required this.onQuickAddExpense,
  });

  final Color primary;
  final Color onSurface;
  final VoidCallback onOpenDashboard;
  final VoidCallback onOpenBudget;
  final VoidCallback onOpenSavings;
  final VoidCallback onQuickAddExpense;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionCard(
            title: 'Dashboard',
            icon: Icons.home_rounded,
            onTap: onOpenDashboard,
            primary: primary,
            onSurface: onSurface,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ActionCard(
            title: 'Budget',
            icon: Icons.pie_chart_rounded,
            onTap: onOpenBudget,
            primary: primary,
            onSurface: onSurface,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ActionCard(
            title: 'Savings',
            icon: Icons.savings_rounded,
            onTap: onOpenSavings,
            primary: primary,
            onSurface: onSurface,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ActionCard(
            title: 'Add',
            icon: Icons.add_circle_rounded,
            onTap: onQuickAddExpense,
            primary: primary,
            onSurface: onSurface,
          ),
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.title,
    required this.icon,
    required this.onTap,
    required this.primary,
    required this.onSurface,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color primary;
  final Color onSurface;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: onSurface.withOpacity(0.02),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: onSurface.withOpacity(0.08)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: primary, size: 24),
              const SizedBox(height: 6),
              Text(
                title,
                style: TextStyle(
                  color: onSurface.withOpacity(0.85),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ===== RECENT ACTIVITY TILE =====
class _RecentTile extends StatelessWidget {
  const _RecentTile({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.icon,
    required this.color,
    required this.onSurface,
  });

  final String title;
  final String subtitle;
  final String amount;
  final IconData icon;
  final Color color;
  final Color onSurface;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: onSurface.withOpacity(0.02),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: onSurface.withOpacity(0.08)),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                      color: onSurface.withOpacity(0.95),
                      fontWeight: FontWeight.w700,
                    )),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: onSurface.withOpacity(0.6),
                    fontSize: 12.5,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: onSurface.withOpacity(0.9),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

// ===== MOCK DATA (replace with your real recent expenses) =====
class _RecentItem {
  final String title;
  final String category;
  final String amount;
  final IconData icon;
  _RecentItem(this.title, this.category, this.amount, this.icon);
}

final _mockRecent = <_RecentItem>[
  _RecentItem('Lunch', 'Food', 'Ksh 450', Icons.restaurant_rounded),
  _RecentItem('Matatu', 'Transport', 'Ksh 120', Icons.directions_bus_rounded),
  _RecentItem('Notebook', 'Books', 'Ksh 300', Icons.book_rounded),
];
