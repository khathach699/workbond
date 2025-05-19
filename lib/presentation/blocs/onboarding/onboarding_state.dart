abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingStatus extends OnboardingState {
  final bool hasSeenOnboarding;

  OnboardingStatus(this.hasSeenOnboarding);
}
