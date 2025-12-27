// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_story_app/data/models/user_model.dart';

class StoryModel {
  final int id;
  final int userId;
  final String title;
  final String content;
  final String? image;
  final String? imageUrl;
  final UserModel? user;
  final DateTime? createdAt;
  final DateTime? updateAt;
  StoryModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    this.image,
    this.imageUrl,
    this.user,
    this.createdAt,
    this.updateAt,
  });

  StoryModel copyWith({
    int? id,
    int? userId,
    String? title,
    String? content,
    String? image,
    String? imageUrl,
    UserModel? user,
    DateTime? createdAt,
    DateTime? updateAt,
  }) {
    return StoryModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      content: content ?? this.content,
      image: image ?? this.image,
      imageUrl: imageUrl ?? this.imageUrl,
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
      updateAt: updateAt ?? this.updateAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'title': title,
      'content': content,
      'image': image,
      'imageUrl': imageUrl,
      'user': user?.toMap(),
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updateAt': updateAt?.millisecondsSinceEpoch,
    };
  }

  factory StoryModel.fromMap(Map<String, dynamic> map) {
    return StoryModel(
      id: map['id'] as int,
      userId: map['userId'] as int,
      title: map['title'] as String,
      content: map['content'] as String,
      image: map['image'] != null ? map['image'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      user: map['user'] != null
          ? UserModel.fromMap(map['user'] as Map<String, dynamic>)
          : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updateAt: map['updateAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updateAt'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoryModel.fromJson(String source) =>
      StoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String get formattedDate {
    if (createdAt == null) return '';

    final now = DateTime.now();
    final difference = now.difference(createdAt!);

    if (difference.inDays > 7) {
      return '${createdAt!.day}/${createdAt!.month}/${createdAt!.year}';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} hari lalu';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} jam lalu';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} menit lalu';
    } else {
      return 'Baru saja';
    }
  }

  @override
  String toString() {
    return 'StoryModel(id: $id, userId: $userId, title: $title, content: $content, image: $image, imageUrl: $imageUrl, user: $user, createdAt: $createdAt, updateAt: $updateAt)';
  }

  @override
  bool operator ==(covariant StoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.title == title &&
        other.content == content &&
        other.image == image &&
        other.imageUrl == imageUrl &&
        other.user == user &&
        other.createdAt == createdAt &&
        other.updateAt == updateAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        title.hashCode ^
        content.hashCode ^
        image.hashCode ^
        imageUrl.hashCode ^
        user.hashCode ^
        createdAt.hashCode ^
        updateAt.hashCode;
  }
}
