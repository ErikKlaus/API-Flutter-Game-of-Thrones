class Karakter {
  final int id;
  final String fullName;
  final String title;
  final String family;
  final String imageUrl;

  const Karakter({
    required this.id,
    required this.fullName,
    required this.title,
    required this.family,
    required this.imageUrl,
  });

  factory Karakter.fromJson(Map<String, dynamic> json) {
    return Karakter(
      id: json['id'] as int,
      fullName: (json['fullName'] ?? '') as String,
      title: (json['title'] ?? 'Tanpa Title') as String,
      family: (json['family'] ?? 'Tanpa Keluarga') as String,
      imageUrl: (json['imageUrl'] ?? '') as String,
    );
  }
}
