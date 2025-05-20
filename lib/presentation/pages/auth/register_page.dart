import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:toastification/toastification.dart';
import 'package:workbond/core/utils/app_images.dart';
import 'package:workbond/core/utils/app_strings.dart';
import 'package:workbond/core/utils/responsive.dart';
import 'package:workbond/core/utils/responsive_helper.dart';
import 'package:workbond/core/utils/toast_utils.dart';
import 'package:workbond/core/validator/auth_validator.dart';
import 'package:workbond/presentation/blocs/auth/register/register_event.dart';
import 'package:workbond/presentation/blocs/auth/register/register_state.dart';
import 'package:workbond/presentation/widgets/custom_button.dart';
import 'package:workbond/presentation/widgets/custom_text_field.dart';
import '../../blocs/auth/register/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _fullNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Xử lý submit form đăng ký
  void _onRegisterPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<RegisterBloc>().add(
            RegisterSubmitted(
              _fullNameController.text.trim(),
              _emailController.text.trim(),
              _passwordController.text.trim(),
            ),
          );
    }
  }

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
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: responsive.adaptiveValue(
                    mobile: double.infinity,
                    tablet: 500.w,
                    desktop: 400.w,
                  ),
                ),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: responsive.heightPercentage(3)),
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
                        controller: _emailController,
                        prefixIcon: Icons.email_outlined,
                        hintText: AppStrings.hindEmail,
                        validator: (value) =>
                            AuthValidator.validateEmail(value?.trim() ?? ''),
                        onTap: () => print('Email field tapped'),
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
                        controller: _fullNameController,
                        prefixIcon: Icons.person,
                        hintText: AppStrings.hindRegisterFullname,
                        validator: (value) =>
                            AuthValidator.validateFullName(value?.trim() ?? ''),
                        onTap: () => print('FullName field tapped'),
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
                        controller: _passwordController,
                        prefixIcon: Icons.lock,
                        hintText: AppStrings.password,
                        suffixIcon: Icons.remove_red_eye,
                        obscureText: true,
                        validator: (value) =>
                            AuthValidator.validatePassword(value?.trim() ?? ''),
                        onTap: () => print('Password field tapped'),
                        onSuffixIconTap: () =>
                            print('Password suffix icon tapped'),
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
                        controller: _confirmPasswordController,
                        prefixIcon: Icons.lock,
                        hintText: AppStrings.hindregisterConfirmPassword,
                        suffixIcon: Icons.remove_red_eye,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.emptyPassword;
                          }
                          if (value != _passwordController.text) {
                            return AppStrings.matchPassword;
                          }
                          return null;
                        },
                        onTap: () => print('ConfirmPassword field tapped'),
                        onSuffixIconTap: () =>
                            print('ConfirmPassword suffix icon tapped'),
                      ),
                      SizedBox(height: responsive.heightPercentage(3)),
                      BlocConsumer<RegisterBloc, RegisterState>(
                        listener: (context, state) {
                          if (state is RegisterSuccess) {
                            print(
                                'Navigating to /login due to RegisterSuccess');
                            _emailController.clear();
                            _fullNameController.clear();
                            _passwordController.clear();
                            _confirmPasswordController.clear();
                            ToastUtils.showCustomToast(context,
                                title: "Success",
                                message: "Register Success",
                                type: ToastificationType.success);
                            context.go('/login');
                          } else if (state is RegisterError) {
                            ToastUtils.showCustomToast(context,
                                title: "Error",
                                message: state.message,
                                type: ToastificationType.error);
                          }
                        },
                        builder: (context, state) {
                          return CustomButton(
                            text: AppStrings.register,
                            onPressed: () => _onRegisterPressed(context),
                            isLoading: state is RegisterLoading,
                          );
                        },
                      ),
                      SizedBox(height: responsive.heightPercentage(4)),
                      Row(
                        children: [
                          const Expanded(child: Divider(thickness: 0.5)),
                          Padding(
                            padding: responsive.padding(right: 10, left: 10),
                            child: Text(
                              AppStrings.or,
                              style:
                                  TextStyle(fontSize: responsive.fontSize(16)),
                            ),
                          ),
                          const Expanded(child: Divider(thickness: 0.5)),
                        ],
                      ),
                      SizedBox(height: responsive.heightPercentage(4)),
                      const CustomButton(
                        icon: AntDesign.google_outline,
                        text: AppStrings.loginWithGoogle,
                        onPressed: null, // Tạm vô hiệu hóa
                      ),
                      SizedBox(height: responsive.heightPercentage(5)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.didntHaveAccount,
                            style: TextStyle(fontSize: responsive.fontSize(16)),
                          ),
                          SizedBox(width: responsive.widthPercentage(1)),
                          TextButton(
                            onPressed: () => context.go('/login'),
                            child: Text(
                              AppStrings.login,
                              style:
                                  TextStyle(fontSize: responsive.fontSize(16)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
