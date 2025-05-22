import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workbond/core/utils/app_colors.dart';
import 'package:workbond/core/utils/app_strings.dart';
import 'package:workbond/core/utils/responsive.dart';

class AttendanceCards extends StatelessWidget {
  final Responsive responsive;

  const AttendanceCards({super.key, required this.responsive});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: responsive.heightPercentage(2),
      mainAxisSpacing: responsive.widthPercentage(2),
      childAspectRatio: 1.3,
      children: [
        _buildAttendanceCard(
          icon: Icons.login,
          title: AppStrings.checkIn,
          time: "10:20 am",
          subtitle: AppStrings.onTime,
        ),
        _buildAttendanceCard(
          icon: Icons.logout,
          title: AppStrings.checkOut,
          time: "07:00 pm",
          subtitle: AppStrings.goHome,
        ),
        _buildAttendanceCard(
          icon: Icons.free_breakfast,
          title: AppStrings.breakTime,
          time: "00:30 min",
          subtitle: AppStrings.avgTine,
        ),
        _buildAttendanceCard(
          icon: Icons.calendar_today,
          title: AppStrings.totolDay,
          time: "28",
          subtitle: AppStrings.workingDay,
        ),
      ],
    );
  }

  Widget _buildAttendanceCard({
    required IconData icon,
    required String title,
    required String time,
    required String subtitle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.grey.withOpacity(0.7),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(15.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.grey, size: responsive.fontSize(20)),
              SizedBox(
                width: responsive.widthPercentage(2),
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: responsive.fontSize(14),
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: responsive.heightPercentage(1)),
          Text(
            time,
            style: TextStyle(
              fontSize: responsive.fontSize(18),
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          SizedBox(height: responsive.heightPercentage(0.5)),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: responsive.fontSize(12),
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
