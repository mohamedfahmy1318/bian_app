import 'package:film/core/utils/app_colors.dart';
import 'package:film/features/tabs/azkar/presentation/pages/azkar_screen.dart';
import 'package:film/features/tabs/hadith/presentation/pages/hadith_screen.dart';
import 'package:film/features/tabs/prayer/presentation/pages/prayer_screen.dart';
import 'package:film/features/tabs/sebha/presentation/pages/sbha_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HadithScreen(),
    AzkarScreen(),
    AnimatedPrayerScreen(),
    const DarkAnimatedSebhaScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.ad_units_sharp),
            label: 'الأحاديث',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmarks_rounded),
            label: 'الاذكار',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_filled),
            label: 'مواقيت الصلاه',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'القبلة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_backup_restore),
            label: ' سبحة',
          ),
        ],
      ),
    );
  }
}
