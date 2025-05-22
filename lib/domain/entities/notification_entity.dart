class NotificationEntity {
  final String avatarUrl;
  final String title;
  final String content;
  final DateTime time;
  final bool isRead;
  final String link;

  NotificationEntity({
    required this.avatarUrl,
    required this.title,
    required this.content,
    required this.time,
    required this.isRead,
    required this.link,
  });
}
