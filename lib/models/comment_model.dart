class Comment {
  final String userId;
  final String userName;
  final String text;
  final DateTime timestamp;

  Comment({
    required this.userId,
    required this.userName,
    required this.text,
    required this.timestamp,
  });


   factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      userId: json['userId'],
      userName: json['userName'],
      text: json['text'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'text': text,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
