import 'package:flutter/material.dart';
import 'package:workbond/core/utils/responsive.dart';

// ignore: must_be_immutable
class BuildOnboardingImage extends StatelessWidget {
  final String path;
  Responsive responsive;
  BuildOnboardingImage({
    super.key,
    required this.path,
    required this.responsive,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        path,
        width: responsive.widthPercentage(60),
        height: responsive.heightPercentage(30),
        fit: BoxFit.contain,
      ),
    );
  }
}
