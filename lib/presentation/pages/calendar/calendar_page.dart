import 'package:flutter/material.dart';
import 'package:workbond/core/utils/responsive.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

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
              'Calendar',
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
                title: Text('May 21, 2025'),
                subtitle: Text('Check In: 10:00 AM | Check Out: 07:00 PM'),
                trailing: const Icon(Icons.event),
              ),
            ),
            // Thêm logic hiển thị lịch hoặc danh sách sự kiện thực tế nếu có
          ],
        ),
      ),
    );
  }
}
