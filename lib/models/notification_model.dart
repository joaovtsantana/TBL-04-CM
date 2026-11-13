
class NotificationModel {
  final String title;
  final String body;
  final String? route;
  final DateTime createdAt;

  NotificationModel({
    required this.title,
    required this.body,
    this.route,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}
