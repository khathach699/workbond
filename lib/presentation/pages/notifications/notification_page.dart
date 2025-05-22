import 'package:flutter/material.dart';
import 'package:workbond/domain/entities/notification_entity.dart';
import 'package:workbond/presentation/pages/notifications/widgets/notification_card.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  // Danh sách mẫu thông báo (có thể thay bằng API)
  final List<NotificationEntity> notifications = [
    NotificationEntity(
      avatarUrl:
          'https://th.bing.com/th/id/R.31eb7fc0690c730775f9af270f8e7983?rik=KuguRdtRIxRjVg&riu=http%3a%2f%2fgetwallpapers.com%2fwallpaper%2ffull%2f7%2fc%2f7%2f624165.jpg&ehk=ekLzKg27ujZHSZ4IilboRtSswc%2bQgnlKm3D14cRUWsc%3d&risl=&pid=ImgRaw&r=0',
      title: 'Cập nhật mới',
      content: 'Bạn có một cập nhật mới từ hệ thống.',
      time: DateTime.now().subtract(const Duration(minutes: 10)),
      isRead: false,
      link: '/details/1',
    ),
    NotificationEntity(
      avatarUrl:
          'https://th.bing.com/th/id/R.31eb7fc0690c730775f9af270f8e7983?rik=KuguRdtRIxRjVg&riu=http%3a%2f%2fgetwallpapers.com%2fwallpaper%2ffull%2f7%2fc%2f7%2f624165.jpg&ehk=ekLzKg27ujZHSZ4IilboRtSswc%2bQgnlKm3D14cRUWsc%3d&risl=&pid=ImgRaw&r=0',
      title: 'Tin nhắn mới',
      content: 'Lan gửi bạn một tin nhắn.',
      time: DateTime.now().subtract(const Duration(hours: 1)),
      isRead: true,
      link: '/messages/2',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông báo'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: notifications.isEmpty
          ? const Center(child: Text('Không có thông báo nào.'))
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return NotificationCard(notification: notifications[index]);
              },
            ),
    );
  }
}
