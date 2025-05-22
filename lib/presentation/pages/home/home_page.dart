import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workbond/core/utils/app_colors.dart';
import 'package:workbond/core/utils/responsive.dart';
import 'package:workbond/presentation/pages/calendar/calendar_page.dart';
import 'package:workbond/presentation/pages/home/widgets/custom_appbar.dart';
import 'package:workbond/presentation/pages/home/widgets/home_content.dart';
import 'package:workbond/presentation/pages/messages/group_page.dart';
import 'package:workbond/presentation/pages/profiles/profile_page.dart';
import 'package:workbond/presentation/widgets/bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const CalendarPage(),
    const MessagePage(),
    const ProfilePage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    final List<PreferredSizeWidget?> appBars = [
      CustomAppBar(height: responsive.heightPercentage(10)),
      AppBar(title: const Text('Calendar')),
      null, // GroupPage không có AppBar
      null
    ];

    return Scaffold(
      appBar: appBars[_currentIndex],
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        responsive: responsive,
      ),
    );
  }
}
