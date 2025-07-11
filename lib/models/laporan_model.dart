class Laporan {
  final int id;
  final String title;
  final String description;
  final String location;
  final double latitude;
  final double longitude;
  final String status;
  final String? photoUrl;
  final String? category;
  final int categoryId;
  final String? userName;

  Laporan({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.categoryId,
    this.photoUrl,
    this.category,
    this.userName,
  });

  factory Laporan.fromJson(Map<String, dynamic> json) {
    return Laporan(
      id: json['id'],
      title: json['title'] ?? '-',
      description: json['description'] ?? '-',
      location: json['location'] ?? '${json['latitude']}, ${json['longitude']}',
      latitude: double.tryParse(json['latitude'].toString()) ?? 0.0,
      longitude: double.tryParse(json['longitude'].toString()) ?? 0.0,
      status: json['status'] ?? 'pending',
      photoUrl: json['photo_url'],
      category:
          json['category'] is String
              ? json['category']
              : json['category']?['name'],
      categoryId: int.tryParse(json['category_id'].toString()) ?? 0,
      userName: json['user']?['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'location': location,
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'category_id': categoryId.toString(),
      'status': status,
      'photo_url': photoUrl,
      'category': category,
    };
  }
}
