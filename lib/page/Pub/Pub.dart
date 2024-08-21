class Pub {
  final int id;
  final String libelle;
  final String contenu;
  final String image;
  Pub ({
    required this.id,
    required this.libelle,
    required this.contenu,
    required this.image,
  });
  factory Pub.fromJson(Map<String, dynamic> json) {
    return Pub(
      id: json['id'],
      libelle: json['libelle'],
      contenu: json['contenu'],
      image: json['image'],
    );
  }
}