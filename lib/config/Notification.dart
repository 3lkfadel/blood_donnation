class AppNotification {
  final String titre;
  final String message;
  final bool isRead;
  final int id;
  final int annonceId;

  AppNotification({
    required this.titre,
    required this.message,
    required this.isRead,
    required this.id,
    required this.annonceId,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      titre: json['titre'] as String? ?? "",
      message: json['message'] as String? ?? "",
      isRead: json['isRead'] as bool? ?? false,
      id: json['id'] as int? ?? 0,
      annonceId: json['annonce_id'] as int? ?? 0,
    );
  }
}


