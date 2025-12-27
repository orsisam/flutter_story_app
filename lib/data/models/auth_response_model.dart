// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_story_app/data/models/user_model.dart';

class AuthResponseModel {
  final bool status;
  final String message;
  final UserModel user;
  final String token;
  AuthResponseModel({
    required this.status,
    required this.message,
    required this.user,
    required this.token,
  });

  AuthResponseModel copyWith({
    bool? status,
    String? message,
    UserModel? user,
    String? token,
  }) {
    return AuthResponseModel(
      status: status ?? this.status,
      message: message ?? this.message,
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'message': message,
      'user': user.toMap(),
      'token': token,
    };
  }

  factory AuthResponseModel.fromMap(Map<String, dynamic> map) {
    return AuthResponseModel(
      status: map['status'] as bool,
      message: map['message'] as String,
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthResponseModel.fromJson(String source) =>
      AuthResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AuthResponseModel(status: $status, message: $message, user: $user, token: $token)';
  }

  @override
  bool operator ==(covariant AuthResponseModel other) {
    if (identical(this, other)) return true;

    return other.status == status &&
        other.message == message &&
        other.user == user &&
        other.token == token;
  }

  @override
  int get hashCode {
    return status.hashCode ^ message.hashCode ^ user.hashCode ^ token.hashCode;
  }
}
