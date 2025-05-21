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
    const HomeContent(), // Trang có AppBar tùy chỉnh
    const CalendarPage(), // Trang có thể có AppBar riêng
    const GroupPage(), // Trang không có AppBar
    const ProfilePage(), // Trang có thể có AppBar riêng
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    // Xác định AppBar tương ứng với từng trang
    final List<PreferredSizeWidget?> appBars = [
      CustomAppBar(
          height: responsive.heightPercentage(10)), // AppBar cho HomeContent
      AppBar(title: const Text('Calendar')), // AppBar đơn giản cho CalendarPage
      null, // GroupPage không có AppBar
      null // AppBar đơn giản cho ProfilePage
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
