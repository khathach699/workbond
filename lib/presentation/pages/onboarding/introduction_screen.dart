import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:workbond/core/utils/app_images.dart';
import 'package:workbond/core/utils/app_strings.dart';
import 'package:workbond/core/utils/app_style.dart';
import 'package:workbond/core/utils/responsive.dart';
import 'package:workbond/presentation/blocs/onboarding/onboarding_bloc.dart';
import 'package:workbond/presentation/blocs/onboarding/onboarding_event.dart';
import 'package:workbond/presentation/widgets/build_onboarding_image.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final List<PageViewModel> _pages = [
      PageViewModel(
        title: AppStrings.onboardingTitle1,
        body: AppStrings.onboardingBody1,
        image: BuildOnboardingImage(
          path: AppImages.onboarding1,
          responsive: responsive,
        ),
      ),
      PageViewModel(
        title: AppStrings.onboardingTitle2,
        body: AppStrings.onboardingBody2,
        image: BuildOnboardingImage(
          path: AppImages.onboarding1,
          responsive: responsive,
        ),
      ),
      PageViewModel(
        title: AppStrings.onboardingTitle3,
        body: AppStrings.onboardingBody3,
        image: BuildOnboardingImage(
          path: AppImages.onboarding1,
          responsive: responsive,
        ),
      ),
    ];

    return Scaffold(
      body: IntroductionScreen(
        pages: _pages.map((page) {
          return PageViewModel(
            titleWidget: Text(
              page.title!,
              style: AppStyle.heading2(context),
            ),
            bodyWidget: Text(
              page.body!,
              style: AppStyle.bodyText(context),
              textAlign: TextAlign.center,
            ),
            image: SizedBox(
              width: responsive.widthPercentage(60),
              child: page.image,
            ),
            decoration: PageDecoration(
              pageColor: AppStyle.appTheme(context).scaffoldBackgroundColor,
              titlePadding: AppStyle.defaultPadding(context),
              bodyPadding: AppStyle.defaultPadding(context),
            ),
          );
        }).toList(),
        onDone: () {
          context.read<OnboardingBloc>().add(CompleteOnboarding());
          context.go('/login');
          // context.push('/login');
        },
        onSkip: () {
          context.read<OnboardingBloc>().add(CompleteOnboarding());
          context.go('/login');
        },
        showSkipButton: true,
        skip: Text(
          AppStrings.skip,
          style: AppStyle.caption(
            context,
          ).copyWith(color: AppStyle.appTheme(context).primaryColor),
        ),
        next: Icon(
          Icons.arrow_forward,
          size: responsive.fontSize(24),
          color: AppStyle.appTheme(context).primaryColor,
        ),
        done: Text(
          AppStrings.next,
          style: AppStyle.bodyText(context).copyWith(
            fontWeight: FontWeight.w600,
            color: AppStyle.appTheme(context).primaryColor,
          ),
        ),
        dotsDecorator: DotsDecorator(
          size: Size.square(responsive.fontSize(10)),
          activeSize: Size(responsive.fontSize(22), responsive.fontSize(10)),
          activeColor: AppStyle.appTheme(context).primaryColor,
          color: AppStyle.appTheme(
            context,
          ).colorScheme.onSurface.withOpacity(0.3),
          spacing: EdgeInsets.symmetric(horizontal: responsive.fontSize(4)),
        ),
        globalBackgroundColor:
            AppStyle.appTheme(context).scaffoldBackgroundColor,
      ),
    );
  }
}
