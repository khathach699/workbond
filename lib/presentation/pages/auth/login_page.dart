import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workbond/core/utils/responsive.dart';
import 'package:workbond/core/utils/responsive_helper.dart';
import 'package:workbond/presentation/blocs/auth/auth_event.dart';
import 'package:workbond/presentation/blocs/auth/auth_state.dart';
import 'package:workbond/presentation/widgets/custom_button.dart';
import '../../blocs/auth/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: responsive.padding(
            horizontal: ResponsiveHelper.isMobile(context) ? 20 : 100,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'HR Management',
                style: TextStyle(
                  fontSize: ResponsiveHelper.getFontSize(context, 24.sp),
                ),
              ),
              SizedBox(height: responsive.scaleHeight(20)),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(height: responsive.scaleHeight(10)),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: responsive.scaleHeight(20)),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Login successful')));
                  } else if (state is AuthError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return CircularProgressIndicator();
                  }
                  return CustomButton(
                    text: 'Login',
                    onPressed: () {
                      context.read<AuthBloc>().add(
                        LoginSubmitted(
                          _emailController.text,
                          _passwordController.text,
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
