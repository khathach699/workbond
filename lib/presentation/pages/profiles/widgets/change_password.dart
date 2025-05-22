import 'package:flutter/material.dart';
import 'package:workbond/core/utils/app_colors.dart';
import 'package:workbond/core/utils/responsive.dart';
import 'package:workbond/presentation/widgets/custom_button.dart';
import 'package:workbond/presentation/widgets/custom_text_field.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Passowrd"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: responsive.padding(all: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Pasword",
              style: TextStyle(fontSize: responsive.fontSize(16)),
            ),
            SizedBox(
              height: responsive.heightPercentage(0.5),
            ),
            CustomTextField(
              hintText: "Enter new password",
              prefixIcon: Icons.password,
              suffixIcon: Icons.remove_red_eye,
              obscureText: true,
            ),
            SizedBox(
              height: responsive.heightPercentage(1),
            ),
            Text(
              "Confirm new Pasword",
              style: TextStyle(fontSize: responsive.fontSize(16)),
            ),
            SizedBox(
              height: responsive.heightPercentage(0.5),
            ),
            CustomTextField(
              hintText: "Enter confirm new password",
              prefixIcon: Icons.password,
              suffixIcon: Icons.remove_red_eye,
              obscureText: true,
            ),
            SizedBox(
              height: responsive.heightPercentage(3),
            ),
            CustomButton(text: "Update")
          ],
        ),
      ),
    );
  }
}
