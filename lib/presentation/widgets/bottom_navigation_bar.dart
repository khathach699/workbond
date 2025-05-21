// lib/presentation/widgets/custom_bottom_navigation_bar.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workbond/core/utils/app_colors.dart';
import 'package:workbond/core/utils/responsive.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final Responsive responsive;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.responsive,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed, // Đảm bảo các icon không di chuyển
      backgroundColor: AppColors.backgroundColor,
      selectedItemColor: AppColors.primaryColor, // Màu khi icon được chọn
      unselectedItemColor: AppColors.textColor, // Màu khi icon không được chọn
      showSelectedLabels: false, // Ẩn label khi chọn
      showUnselectedLabels: true, // Ẩn label khi không chọn
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
            size: responsive.fontSize(24),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.calendar_today_outlined,
            size: responsive.fontSize(24),
          ),
          label: 'Calendar',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.message_outlined,
            size: responsive.fontSize(24),
          ),
          label: 'Message',
        ),
        BottomNavigationBarItem(
          icon: Stack(
            children: [
              Icon(
                Icons.person_outline,
                size: responsive.fontSize(24),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: CircleAvatar(
                  radius: 8.r,
                  backgroundColor: AppColors.secondaryColor,
                  child: Text(
                    '8',
                    style: TextStyle(
                      fontSize: responsive.fontSize(10),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
