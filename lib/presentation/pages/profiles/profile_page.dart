import 'package:flutter/material.dart';
import 'package:workbond/core/utils/responsive.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: responsive.padding(all: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile',
              style: TextStyle(
                fontSize: responsive.fontSize(24),
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: responsive.heightPercentage(2)),
            Card(
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.person),
                title: Text('User Name'),
                subtitle: Text('Joined: May 1, 2025'),
              ),
            ),
            // Thêm thông tin chi tiết như email, settings nếu có
          ],
        ),
      ),
    );
  }
}
