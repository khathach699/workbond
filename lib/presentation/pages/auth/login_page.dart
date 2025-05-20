import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:logger/web.dart';
import 'package:workbond/core/utils/app_images.dart';
import 'package:workbond/core/utils/app_strings.dart';
import 'package:workbond/core/utils/responsive.dart';
import 'package:workbond/core/utils/responsive_helper.dart';
import 'package:workbond/presentation/blocs/auth/login/login_bloc.dart';
import 'package:workbond/presentation/blocs/auth/login/login_event.dart';
import 'package:workbond/presentation/blocs/auth/login/login_state.dart';
import 'package:workbond/presentation/widgets/custom_button.dart';
import 'package:workbond/presentation/widgets/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: ResponsiveHelper.getPadding(context),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: responsive.adaptiveValue(
                    mobile: double.infinity, tablet: 500.w, desktop: 400.w),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    AppImages.logo,
                    height: responsive.scaleWidth(100),
                    width: responsive.scaleWidth(100),
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: responsive.heightPercentage(2)),
                  Text(
                    AppStrings.loginTitle,
                    style: TextStyle(
                      fontSize: responsive.fontSize(20),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: responsive.heightPercentage(1)),
                  Text(AppStrings.loginSubtitle,
                      style: TextStyle(
                        fontSize: responsive.fontSize(16),
                      )),
                  SizedBox(height: responsive.heightPercentage(3)),
                  Text(AppStrings.email,
                      style: TextStyle(
                        fontSize: responsive.fontSize(14),
                      )),
                  SizedBox(height: responsive.heightPercentage(1)),
                  CustomTextField(
                    controller: emailController,
                    prefixIcon: Icons.email_outlined,
                    hintText: AppStrings.hindEmail,
                  ),
                  SizedBox(height: responsive.heightPercentage(2)),
                  Text(AppStrings.password,
                      style: TextStyle(
                        fontSize: responsive.fontSize(14),
                      )),
                  SizedBox(height: responsive.heightPercentage(1)),
                  CustomTextField(
                    controller: passwordController,
                    prefixIcon: Icons.lock,
                    hintText: AppStrings.password,
                    suffixIcon: Icons.remove_red_eye,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: (false),
                            onChanged: (value) {},
                          ),
                          Text(AppStrings.remoberMe,
                              style:
                                  TextStyle(fontSize: responsive.fontSize(16)))
                        ],
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(AppStrings.forgetPassword,
                              style:
                                  TextStyle(fontSize: responsive.fontSize(16))))
                    ],
                  ),
                  SizedBox(
                    height: responsive.heightPercentage(3),
                  ),
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      return CustomButton(
                        text: AppStrings.login,
                        onPressed: () {
                          if (emailController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty) {
                            context.read<LoginBloc>().add(
                                  LoginSubmitted(
                                    emailController.text,
                                    passwordController.text,
                                  ),
                                );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Please fill all fields')),
                            );
                          }
                        },
                        isLoading: state is AuthLoading, // Sync with bloc state
                      );
                    },
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
                          style: TextStyle(fontSize: responsive.fontSize(16))),
                      SizedBox(
                        width: responsive.widthPercentage(1),
                      ),
                      TextButton(
                        onPressed: () {
                          context.push("/register");
                        },
                        child: Text(
                          AppStrings.register,
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
    );
  }
}
