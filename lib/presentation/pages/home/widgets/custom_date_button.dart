import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workbond/core/utils/app_colors.dart';
import 'package:workbond/core/utils/responsive.dart';

class DateButton extends StatelessWidget {
  final int date;
  final String day;
  final bool isToday;
  final Responsive responsive;

  const DateButton({
    super.key,
    required this.date,
    required this.day,
    required this.isToday,
    required this.responsive,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8), // Chỉ cần margin ngang
        padding: responsive.padding(all: 12),
        width: responsive
            .widthPercentage(18), // Đặt chiều rộng cố định để tránh co giãn
        decoration: BoxDecoration(
          color: isToday
              ? Colors.blue
              : AppColors.primaryColor, // Làm nổi bật ngày hiện tại
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          children: [
            Text(
              "$date",
              style: TextStyle(
                fontSize: responsive.fontSize(16),
                fontWeight: FontWeight.bold,
                color: isToday ? Colors.white : AppColors.textColor,
              ),
            ),
            SizedBox(
              height: responsive.heightPercentage(0.5),
            ),
            Text(
              day,
              style: TextStyle(
                fontSize: responsive.fontSize(14),
                color: isToday ? Colors.white : AppColors.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
