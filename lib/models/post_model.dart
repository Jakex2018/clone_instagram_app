import 'package:front_end_instagram/models/comment_model.dart';

class Postmodel {
  final String id;
  final String userId;
  final String imageUrl;
  final String? description;
  List<String>? likes;
  List<Comment>? comments;

  final String timeAgo;
  final DateTime createdAt;
  int? shareCount;
  Postmodel({
    required this.timeAgo,
    required this.userId,
    required this.id,
    this.description,
    this.shareCount = 0,
    required this.imageUrl,
    this.likes,
    this.comments,
    required this.createdAt,
  });

  factory Postmodel.fromJson(Map<String, dynamic> json) {
    return Postmodel(
      timeAgo: json['timeAgo'] ?? '',
      comments: json['comments'] != null
          ? (json['comments'] as List)
              .map((comment) => Comment.fromJson(comment))
              .toList()
          : [],
      createdAt: DateTime.parse(json['createdAt']),
      id: json['id'],
      userId: json['userId'],
      imageUrl: json['imageUrl'],
      description: json['descripcion'],
      likes: (json['likes'] as List?)?.map((e) => e as String).toList() ?? [],
      shareCount: json['shareCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'likes': likes ?? [],
      'shareCount': shareCount,
      'comments': comments?.map((comment) => comment.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return ' Postmodel(id:$id,userId:$userId)';
  }
}
