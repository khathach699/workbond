import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:workbond/core/utils/app_images.dart';
import 'package:workbond/core/utils/app_strings.dart';
import 'package:workbond/core/utils/responsive.dart';
import 'package:workbond/core/utils/responsive_helper.dart';
import 'package:workbond/presentation/widgets/custom_button.dart';
import 'package:workbond/presentation/widgets/custom_text_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: ResponsiveHelper.getPadding(context),
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: responsive.adaptiveValue(
                      mobile: double.infinity, tablet: 500.w, desktop: 400.w),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // <== quan trọng
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: responsive
                            .heightPercentage(3)), // Thêm khoảng trên cho đẹp
                    Image.asset(
                      AppImages.logo,
                      height: responsive.scaleWidth(100),
                      width: responsive.scaleWidth(100),
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: responsive.heightPercentage(2)),
                    Text(
                      AppStrings.registerTitle,
                      style: TextStyle(
                        fontSize: responsive.fontSize(20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: responsive.heightPercentage(1)),
                    Text(
                      AppStrings.registerSubtitle,
                      style: TextStyle(
                        fontSize: responsive.fontSize(16),
                      ),
                    ),
                    SizedBox(height: responsive.heightPercentage(3)),
                    Text(
                      AppStrings.email,
                      style: TextStyle(
                        fontSize: responsive.fontSize(14),
                      ),
                    ),
                    SizedBox(height: responsive.heightPercentage(1)),
                    CustomTextField(
                      prefixIcon: Icons.email_outlined,
                      hintText: AppStrings.hindEmail,
                    ),
                    SizedBox(height: responsive.heightPercentage(2)),
                    Text(
                      AppStrings.fullName,
                      style: TextStyle(
                        fontSize: responsive.fontSize(14),
                      ),
                    ),
                    SizedBox(height: responsive.heightPercentage(1)),
                    CustomTextField(
                      prefixIcon: Icons.person,
                      hintText: AppStrings.hindRegisterFullname,
                    ),
                    SizedBox(height: responsive.heightPercentage(2)),
                    Text(
                      AppStrings.password,
                      style: TextStyle(
                        fontSize: responsive.fontSize(14),
                      ),
                    ),
                    SizedBox(height: responsive.heightPercentage(1)),
                    CustomTextField(
                      prefixIcon: Icons.lock,
                      hintText: AppStrings.password,
                      suffixIcon: Icons.remove_red_eye,
                    ),
                    SizedBox(height: responsive.heightPercentage(2)),
                    Text(
                      AppStrings.registerConfirmPassword,
                      style: TextStyle(
                        fontSize: responsive.fontSize(14),
                      ),
                    ),
                    SizedBox(height: responsive.heightPercentage(1)),
                    CustomTextField(
                      prefixIcon: Icons.lock,
                      hintText: AppStrings.hindregisterConfirmPassword,
                      suffixIcon: Icons.remove_red_eye,
                    ),

                    SizedBox(height: responsive.heightPercentage(3)),
                    CustomButton(
                      text: AppStrings.register,
                      onPressed: () {},
                    ),
                    SizedBox(
                      height: responsive.heightPercentage(4),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                          ),
                        ),
                        Padding(
                            padding: responsive.padding(right: 10, left: 10),
                            child: Text(AppStrings.or,
                                style: TextStyle(
                                    fontSize: responsive.fontSize(16)))),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: responsive.heightPercentage(4),
                    ),
                    CustomButton(
                        icon: AntDesign.google_outline,
                        text: AppStrings.loginWithGoogle,
                        onPressed: () {}),
                    SizedBox(
                      height: responsive.heightPercentage(5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppStrings.didntHaveAccount,
                            style:
                                TextStyle(fontSize: responsive.fontSize(16))),
                        SizedBox(
                          width: responsive.widthPercentage(1),
                        ),
                        TextButton(
                          onPressed: () {
                            context.push("/login");
                          },
                          child: Text(
                            AppStrings.login,
                            style: TextStyle(fontSize: responsive.fontSize(16)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
