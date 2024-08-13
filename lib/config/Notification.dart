class AppNotification {
  final String titre;
  final String message;
  final bool isRead;

  AppNotification({
    required this.titre,
    required this.message,
    required this.isRead,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      titre: json['titre'] as String? ?? "",
      message: json['message'] as String? ?? "",
      isRead: json['isRead'] as bool? ?? false,
    );
  }
}


