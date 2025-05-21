import 'package:flutter/material.dart';
import 'package:workbond/core/utils/app_colors.dart';
import 'package:workbond/core/utils/app_strings.dart';
import 'package:workbond/core/utils/responsive.dart';
import 'package:workbond/presentation/pages/home/widgets/activity_list.dart';
import 'package:workbond/presentation/pages/home/widgets/attendance_cards.dart';
import 'package:workbond/presentation/pages/home/widgets/date_button_row.dart';
import 'package:workbond/presentation/pages/home/widgets/swipe_button.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: responsive.padding(all: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DateButtonRow(
              responsive: responsive,
            ),
            SizedBox(
              height: responsive.heightPercentage(2),
            ),

            // Title Today
            Text(
              AppStrings.todayAtendane,
              style: TextStyle(
                  fontSize: responsive.fontSize(18),
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor),
            ),

            // Button Check in
            SizedBox(height: responsive.heightPercentage(2)),
            AttendanceCards(responsive: responsive),
            SizedBox(height: responsive.heightPercentage(3)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.yourActivity,
                  style: TextStyle(
                      fontSize: responsive.fontSize(18),
                      fontWeight: FontWeight.bold,
                      color: AppColors
                          .textColor // Thay bằng AppColors.textColor nếu có
                      ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    AppStrings.viewAll,
                    style: TextStyle(
                      fontSize: responsive.fontSize(14),
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: responsive.heightPercentage(1)),
            // history check in
            ActivityList(responsive: responsive),

            SizedBox(height: responsive.heightPercentage(3)),

            // swipe to check in
            SwipeButton(responsive: responsive),
          ],
        ),
      ),
    );
  }
}
