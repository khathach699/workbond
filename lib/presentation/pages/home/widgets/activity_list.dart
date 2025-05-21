import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workbond/core/utils/responsive.dart';

class ActivityList extends StatelessWidget {
  final Responsive responsive;

  const ActivityList({super.key, required this.responsive});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 1, // Ví dụ với 1 item như trong hình
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 10.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.all(15.r),
          child: Row(
            children: [
              Icon(Icons.login,
                  color: Colors.grey, size: responsive.fontSize(20)),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Check In",
                    style: TextStyle(
                      fontSize: responsive.fontSize(14),
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "April 17, 2023",
                    style: TextStyle(
                      fontSize: responsive.fontSize(12),
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "10:00 am",
                    style: TextStyle(
                      fontSize: responsive.fontSize(14),
                      fontWeight: FontWeight.bold,
                      color:
                          Colors.black, // Thay bằng AppColors.textColor nếu có
                    ),
                  ),
                  Text(
                    "On Time",
                    style: TextStyle(
                      fontSize: responsive.fontSize(12),
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
