class HealthCenter {
  final int id;
  final String name;
  final double latitude;
  final double longitude;

  HealthCenter({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  // Fonction pour convertir une réponse JSON en un objet HealthCenter
  factory HealthCenter.fromJson(Map<String, dynamic> json) {
    return HealthCenter(
      id: json['id'],
      name: json['nom'],
      latitude: double.tryParse(json['latitude'].toString()) ?? 0.0,
      longitude: double.tryParse(json['longitude'].toString()) ?? 0.0,
    );
  }
}
