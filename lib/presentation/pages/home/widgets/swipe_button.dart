import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workbond/core/utils/app_strings.dart';
import 'package:workbond/core/utils/responsive.dart';
import 'package:slide_to_act/slide_to_act.dart';

class SwipeButton extends StatelessWidget {
  final Responsive responsive;

  const SwipeButton({super.key, required this.responsive});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: responsive.padding(all: 0),
      child: SlideAction(
        height: responsive.heightPercentage(6),
        borderRadius: 10.r,
        innerColor: Colors.white,
        outerColor: Colors.blue,
        elevation: 2,
        sliderButtonIcon: Icon(Icons.arrow_forward, color: Colors.blue),
        text: AppStrings.swipeCheckIn,
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: responsive.fontSize(16),
        ),
        onSubmit: () {
          // Xử lý khi kéo xong
          print("Check in success!");
        },
      ),
    );
  }
}
