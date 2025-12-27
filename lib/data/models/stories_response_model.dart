// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter_story_app/data/models/story_model.dart';

class StoriesResponseModel {
  final bool status;
  final String message;
  final List<StoryModel> data;
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  StoriesResponseModel({
    required this.status,
    required this.message,
    required this.data,
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
  });

  StoriesResponseModel copyWith({
    bool? status,
    String? message,
    List<StoryModel>? data,
    int? currentPage,
    int? lastPage,
    int? perPage,
    int? total,
  }) {
    return StoriesResponseModel(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      perPage: perPage ?? this.perPage,
      total: total ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'message': message,
      'data': data.map((x) => x.toMap()).toList(),
      'currentPage': currentPage,
      'lastPage': lastPage,
      'perPage': perPage,
      'total': total,
    };
  }

  factory StoriesResponseModel.fromMap(Map<String, dynamic> map) {
    final paginatedData = map['data'] as Map<String, dynamic>;
    final items = paginatedData['data'] as List<dynamic>;

    return StoriesResponseModel(
      status: map['status'] as bool,
      message: map['message'] as String,
      data: items
          .map((e) => StoryModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      currentPage: paginatedData['current_page'] as int? ?? 1,
      lastPage: paginatedData['last_page'] as int? ?? 1,
      perPage: paginatedData['per_page'] as int? ?? 10,
      total: paginatedData['total'] as int? ?? 0,
    );
  }

  bool get hasMore => currentPage < lastPage;
  bool get isEmpty => data.isEmpty;

  String toJson() => json.encode(toMap());

  factory StoriesResponseModel.fromJson(String source) =>
      StoriesResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StoriesResponseModel(status: $status, message: $message, data: $data, currentPage: $currentPage, lastPage: $lastPage, perPage: $perPage, total: $total)';
  }

  @override
  bool operator ==(covariant StoriesResponseModel other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.message == message &&
        listEquals(other.data, data) &&
        other.currentPage == currentPage &&
        other.lastPage == lastPage &&
        other.perPage == perPage &&
        other.total == total;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        message.hashCode ^
        data.hashCode ^
        currentPage.hashCode ^
        lastPage.hashCode ^
        perPage.hashCode ^
        total.hashCode;
  }
}
