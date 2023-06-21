class NotificationModel {
  final DateTime createdAt;
  final int id;
  final bool read;
  final String title;
  final String body;
  final int inspectionId;

  NotificationModel({
    required this.createdAt,
    required this.id,
    required this.read,
    required this.title,
    required this.body,
    required this.inspectionId,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      createdAt: DateTime.parse(json['createdAt']),
      id: json['id'],
      read: json['read'],
      title: json['title'],
      body: json['body'],
      inspectionId: json['inspectionId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt.toIso8601String(),
      'id': id,
      'read': read,
      'title': title,
      'body': body,
      'inspectionId': inspectionId,
    };
  }
}
