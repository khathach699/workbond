import 'package:flutter/material.dart';
import 'package:workbond/core/utils/responsive.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

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
              'Groups',
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
                title: Text('Team A'),
                subtitle: Text('5 Members'),
                trailing: const Icon(Icons.group_add),
              ),
            ),
            // Thêm logic hiển thị danh sách nhóm hoặc thành viên nếu có
          ],
        ),
      ),
    );
  }
}
