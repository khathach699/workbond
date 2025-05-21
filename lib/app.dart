import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:workbond/core/theme/theme.dart';
import 'package:workbond/presentation/blocs/home/calendar/calendar_event.dart';
import 'package:workbond/presentation/blocs/onboarding/onboarding_event.dart';
import 'package:workbond/presentation/blocs/onboarding/onboarding_bloc.dart';
import 'package:workbond/presentation/blocs/home/calendar/calendar_bloc.dart';
import 'package:workbond/presentation/router/app_router.dart';

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<OnboardingBloc>(
              create: (context) {
                final bloc = GetIt.I<OnboardingBloc>();
                bloc.add(CheckOnboardingStatus());
                return bloc;
              },
            ),
            BlocProvider<CalendarBloc>(
              create: (context) => GetIt.I<CalendarBloc>()..add(LoadCalendar()),
            ),
          ],
          child: MaterialApp.router(
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            title: 'HR Management',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.light,
            routerConfig: _appRouter.config(), // No context needed
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
