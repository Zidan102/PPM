import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/repositories/target_harian_repository.dart';
import '../../home/home_screen.dart';
import '../../materi/materi_screen.dart';
import '../../target/target_screen.dart';
import '../../tips_budaya/tips_budaya_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    MateriScreen(),
    TargetScreen(),
    TipsBudayaScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final targetRepo = context.watch<TargetHarianRepository>();
    final sisaTarget = targetRepo.jumlahBelumSelesai;
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: primary.withValues(alpha: 0.12),
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() => _selectedIndex = index);
        },
        destinations: [
          const NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Beranda',
          ),
          const NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book_rounded),
            label: 'Materi',
          ),
          NavigationDestination(
            icon: Badge(
              isLabelVisible: sisaTarget > 0,
              label: Text('$sisaTarget'),
              child: const Icon(Icons.check_circle_outline),
            ),
            selectedIcon: Badge(
              isLabelVisible: sisaTarget > 0,
              label: Text('$sisaTarget'),
              child: const Icon(Icons.check_circle_rounded),
            ),
            label: 'Checklist',
          ),
          const NavigationDestination(
            icon: Icon(Icons.public_outlined),
            selectedIcon: Icon(Icons.public_rounded),
            label: 'Budaya',
          ),
        ],
      ),
    );
  }
}