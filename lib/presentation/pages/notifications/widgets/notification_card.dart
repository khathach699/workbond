import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:workbond/core/utils/responsive.dart';
import 'package:workbond/core/utils/toast_utils.dart';
import 'package:workbond/domain/entities/notification_entity.dart';

class NotificationCard extends StatelessWidget {
  final NotificationEntity notification;
  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    return Card(
      margin: responsive.padding(all: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: InkWell(
        onTap: () {
          ToastUtils.showSuccessToast(context, message: "Navigation Success");
        },
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: responsive.padding(all: 12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.r,
                backgroundImage: NetworkImage(notification.avatarUrl),
                backgroundColor: Colors.grey[200],
                onBackgroundImageError: (_, __) => const Icon(Icons.error),
              ),
              SizedBox(
                width: responsive.widthPercentage(2),
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: notification.isRead
                          ? Colors.grey[600]
                          : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.content,
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('dd/MM/yyyy HH:mm').format(notification.time),
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              )),
              Icon(
                notification.isRead ? Icons.check_circle : Icons.circle,
                color: notification.isRead ? Colors.green : Colors.red,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
