import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/web.dart';
import 'package:workbond/presentation/blocs/auth/login/login_bloc.dart';
import 'package:workbond/presentation/blocs/onboarding/onboarding_bloc.dart';
import 'package:workbond/presentation/blocs/onboarding/onboarding_state.dart';
import 'package:workbond/presentation/pages/auth/login_page.dart';
import 'package:workbond/presentation/pages/auth/register_page.dart';
import 'package:workbond/presentation/pages/home/home_page.dart';
import 'package:workbond/presentation/pages/onboarding/introduction_screen.dart';
import 'package:workbond/presentation/pages/profiles/profile_page.dart';

import '../blocs/auth/register/register_bloc.dart';

class AppRouter {
  var log = Logger();

  GoRouter router() {
    // Access OnboardingBloc from GetIt
    final onboardingState = GetIt.I<OnboardingBloc>().state;
    final initialLocation = kDebugMode
        ? '/login'
        : (onboardingState is OnboardingStatus &&
                onboardingState.hasSeenOnboarding
            ? '/login'
            : '/onboarding');

    return GoRouter(
      initialLocation: initialLocation,
      redirect: (context, state) {
        // Access OnboardingBloc from GetIt in redirect
        final currentOnboardingState = GetIt.I<OnboardingBloc>().state;

        // Redirect from /onboarding to /login if onboarding is complete
        if (currentOnboardingState is OnboardingStatus &&
            currentOnboardingState.hasSeenOnboarding &&
            state.fullPath == '/onboarding') {
          log.i('Redirecting from /onboarding to /login');
          return '/login';
        }

        // Allow all other routes to persist
        log.i('No redirect, staying on ${state.fullPath}');
        return null;
      },
      routes: [
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => BlocProvider(
            create: (context) => GetIt.I<LoginBloc>(),
            child: LoginPage(),
          ),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => BlocProvider(
            create: (context) => GetIt.I<RegisterBloc>(),
            child: RegisterPage(),
          ),
        ),
        GoRoute(
          path: "/profile",
          builder: (context, state) => ProfilePage(),
        )
      ],
    );
  }

  GoRouter config() => router();
}
