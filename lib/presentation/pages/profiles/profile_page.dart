import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:workbond/core/utils/app_colors.dart';
import 'package:workbond/core/utils/app_images.dart';
import 'package:workbond/core/utils/app_strings.dart';
import 'package:workbond/core/utils/responsive.dart';
import 'package:workbond/presentation/pages/profiles/widgets/build_item_menu.dart';
import 'package:workbond/presentation/widgets/custom_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: responsive.padding(all: 10),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: responsive.heightPercentage(3)),
                // Avatar và nút camera
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: responsive.widthPercentage(35),
                      height: responsive.widthPercentage(35),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryColor.withOpacity(0.1),
                            Colors.white
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(
                            color: AppColors.textColor.withOpacity(0.3),
                            width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.2),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 50.r,
                        backgroundColor: AppColors.greyLight,
                        child: ClipOval(
                          child: Image.asset(
                            AppImages.avatar,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () {
                          // TODO: Thêm logic chọn ảnh
                        },
                        child: Container(
                          padding: EdgeInsets.all(6.r),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primaryColor.withOpacity(0.8),
                                AppColors.primaryColor
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26.withOpacity(0.3),
                                blurRadius: 8,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            size: 18.r,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: responsive.heightPercentage(2)),
                Text(
                  AppStrings.name,
                  style: TextStyle(
                    fontSize: responsive.fontSize(20),
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(height: responsive.heightPercentage(0.5)),
                Text(
                  AppStrings.profession,
                  style: TextStyle(
                    fontSize: responsive.fontSize(16),
                    color: AppColors.greyColor,
                  ),
                ),

                // Section Setting
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Settings",
                        style: TextStyle(
                          fontSize: responsive.fontSize(18),
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor,
                        ),
                      ),
                      Divider(color: AppColors.textColor, thickness: 1),
                      SizedBox(height: responsive.heightPercentage(2)),
                      BuildMenuItem(
                        icon: Icons.password,
                        title: "Change Password",
                        onTap: () {
                          context.push("/change_password");
                        },
                      ),
                      BuildMenuItem(
                        icon: Icons.language_outlined,
                        title: "Change Language",
                        onTap: () {
                          context.push("/language");
                        },
                      ),
                      BuildMenuItem(
                          icon: Icons.notification_important,
                          title: "Notification",
                          onTap: () {
                            context.push("/notification");
                          }),
                      BuildMenuItem(
                        icon: Icons.policy,
                        title: "Terms & Conditions",
                        onTap: () {},
                      ),
                      BuildMenuItem(
                        icon: Icons.privacy_tip_outlined,
                        title: "Privacy Policy",
                        onTap: () {},
                      ),
                      Divider(),
                      SizedBox(
                        height: responsive.heightPercentage(2),
                      ),
                      CustomButton(
                        text: "Log Out",
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
                SizedBox(height: responsive.heightPercentage(3)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
