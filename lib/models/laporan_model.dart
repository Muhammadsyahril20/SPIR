class Laporan {
  final String title;
  final String description;
  final String location;
  final double latitude; // Separate field for latitude
  final double longitude; // Separate field for longitude
  final String status;
  final String? photoUrl;
  final String? category;
  final int categoryId; // Required for creating reports

  Laporan({
    required this.title,
    required this.description,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.status,
    required this.categoryId,
    this.photoUrl,
    this.category,
  });

  factory Laporan.fromJson(Map<String, dynamic> json) {
    return Laporan(
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
