import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workbond/core/utils/app_colors.dart';
import 'package:workbond/core/utils/app_images.dart';
import 'package:workbond/core/utils/app_strings.dart';
import 'package:workbond/core/utils/responsive.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  // Truyền height từ ngoài, hoặc mặc định 10% chiều cao màn hình
  const CustomAppBar({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      toolbarHeight: height,
      elevation: 2,
      title: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.greyLight,
            radius: 16.r, // có thể dùng responsive nếu cần
            child: ClipOval(
              child: Image.asset(
                AppImages.avatar,
                width: responsive.widthPercentage(10),
                height: responsive.heightPercentage(10),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: responsive.widthPercentage(3)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.name,
                  style: TextStyle(
                    fontSize: responsive.fontSize(16),
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(height: responsive.heightPercentage(0.4)),
                Text(
                  AppStrings.profession,
                  style: TextStyle(
                    fontSize: responsive.fontSize(14),
                    color: AppColors.textColor,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notification_add,
              size: responsive.fontSize(24),
            ),
            color: AppColors.textColor,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
