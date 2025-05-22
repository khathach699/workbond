import 'package:flutter/material.dart';
import 'package:workbond/core/utils/responsive.dart';
import 'package:workbond/presentation/pages/profiles/widgets/build_item_menu.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Language Selection'),
        backgroundColor: Color(0xFF007BFF),
      ),
      body: Padding(
        padding: responsive.padding(all: 5),
        child: Column(
          children: [
            BuildMenuItem(
              title: "VN",
              onTap: () {},
              icon: Icons.translate,
            ),
            BuildMenuItem(
              title: "JP",
              onTap: () {},
              icon: Icons.translate,
            ),
            BuildMenuItem(
              title: "US",
              onTap: () {},
              icon: Icons.translate,
            )
          ],
        ),
      ),
    );
  }
}
