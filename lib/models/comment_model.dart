class Comment {
  final int id;
  final int userId;
  final String userName;
  final int reportId;
  final String content;
  final DateTime createdAt; // <- ini harus DateTime

  Comment({
    required this.id,
    required this.userId,
    required this.userName,
    required this.reportId,
    required this.content,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      userId: json['user_id'],
      userName: json['user']?['name'] ?? 'Anonim',
      reportId: json['report_id'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
