import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';
import 'package:workbond/core/utils/app_images.dart';
import 'package:workbond/core/utils/app_strings.dart';
import 'package:workbond/core/utils/responsive.dart';
import 'package:workbond/core/utils/responsive_helper.dart';
import 'package:workbond/core/utils/toast_utils.dart';
import 'package:workbond/core/validator/auth_validator.dart';
import 'package:workbond/presentation/blocs/auth/login/login_bloc.dart';
import 'package:workbond/presentation/blocs/auth/login/login_event.dart';
import 'package:workbond/presentation/blocs/auth/login/login_state.dart';
import 'package:workbond/presentation/widgets/custom_button.dart';
import 'package:workbond/presentation/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Tải email và password đã lưu từ SharedPreferences
  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _emailController.text = prefs.getString('email') ?? '';
      _passwordController.text = prefs.getString('password') ?? '';
      _rememberMe = prefs.getBool('rememberMe') ?? false;
    });
  }

  // Lưu email và password vào SharedPreferences
  Future<void> _saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      await prefs.setString('email', _emailController.text.trim());
      await prefs.setString('password', _passwordController.text.trim());
      await prefs.setBool('rememberMe', true);
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
      await prefs.setBool('rememberMe', false);
    }
  }

  // Xử lý đăng nhập
  void _onLoginPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      print('Form validated, sending LoginSubmitted');
      context.read<LoginBloc>().add(
            LoginSubmitted(
              _emailController.text.trim(),
              _passwordController.text.trim(),
            ),
          );
    } else {
      print('Form validation failed');
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
                    mainAxisAlignment: MainAxisAlignment.center,
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
                        AppStrings.loginTitle,
                        style: TextStyle(
                          fontSize: responsive.fontSize(20),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: responsive.heightPercentage(1)),
                      Text(
                        AppStrings.loginSubtitle,
                        style: TextStyle(fontSize: responsive.fontSize(16)),
                      ),
                      SizedBox(height: responsive.heightPercentage(3)),
                      Text(
                        AppStrings.email,
                        style: TextStyle(fontSize: responsive.fontSize(14)),
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
                        AppStrings.password,
                        style: TextStyle(fontSize: responsive.fontSize(14)),
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
                      SizedBox(height: responsive.heightPercentage(1)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    _rememberMe = value ?? false;
                                  });
                                },
                              ),
                              Text(
                                AppStrings.remoberMe,
                                style: TextStyle(
                                    fontSize: responsive.fontSize(16)),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              // TODO: Thêm logic quên mật khẩu
                              print('Forgot password pressed');
                            },
                            child: Text(
                              AppStrings.forgetPassword,
                              style:
                                  TextStyle(fontSize: responsive.fontSize(16)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: responsive.heightPercentage(3)),
                      BlocConsumer<LoginBloc, LoginState>(
                        listener: (context, state) {
                          if (state is AuthSuccess) {
                            _saveCredentials();
                            ToastUtils.showCustomToast(context,
                                title: "Success",
                                message: "Login Success",
                                type: ToastificationType.success);
                            context.go('/home');
                          } else if (state is AuthError) {
                            ToastUtils.showCustomToast(context,
                                title: "Error",
                                message: state.message,
                                type: ToastificationType.success);
                          }
                        },
                        builder: (context, state) {
                          return CustomButton(
                            text: AppStrings.login,
                            onPressed: () => _onLoginPressed(context),
                            isLoading: state is AuthLoading,
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
                        onPressed: null, // TODO: Thêm logic đăng nhập Google
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
                            onPressed: () => context.go('/register'),
                            child: Text(
                              AppStrings.register,
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
