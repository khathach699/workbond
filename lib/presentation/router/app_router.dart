import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import 'package:workbond/presentation/blocs/onboarding/onboarding_bloc.dart';
import 'package:workbond/presentation/pages/onboarding/introduction_screen.dart';
import '../blocs/auth/auth_bloc.dart';
import '../pages/auth/login_page.dart';

class AppRouter {
  final router = GoRouter(
    initialLocation: '/onboarding',
    routes: [
      GoRoute(
        path: "/onboarding",
        builder:
            (context, state) => BlocProvider(
              create: (context) => GetIt.I<OnboardingBloc>(),
              child: OnboardingScreen(),
            ),
      ),

      GoRoute(
        path: '/login',
        builder:
            (context, state) => BlocProvider(
              create: (context) => GetIt.I<AuthBloc>(),
              child: LoginPage(),
            ),
      ),
    ],
  );

  GoRouter config() => router;
}
