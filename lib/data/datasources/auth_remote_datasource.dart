import 'package:dartz/dartz.dart';
import 'package:flutter_story_app/core/constants/variables.dart';
import 'package:flutter_story_app/core/utils/api_handler.dart';
import 'package:flutter_story_app/data/models/auth_response_model.dart';
import 'package:flutter_story_app/data/models/user_model.dart';

class AuthRemoteDatasource {
  // Register user baru
  Future<Either<String, AuthResponseModel>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final result = await ApiHandler.post(
      Variables.register,
      body: {'name': name, 'email': email, 'password': password},
    );

    return result.fold((error) => Left(error), (data) {
      final authResponse = AuthResponseModel.fromMap(data);
      // Simpan token
      ApiHandler.saveToken(authResponse.token);
      return Right(authResponse);
    });
  }

  // Login user
  Future<Either<String, AuthResponseModel>> login({
    required String email,
    required String password,
  }) async {
    final result = await ApiHandler.post(
      Variables.login,
      body: {'email': email, 'password': password},
    );

    return result.fold((error) => Left(error), (data) {
      final authResponse = AuthResponseModel.fromMap(data);
      // Simpan token
      ApiHandler.saveToken(authResponse.token);
      return Right(authResponse);
    });
  }

  // Logout user
  Future<Either<String, String>> logout() async {
    final result = await ApiHandler.post(Variables.logout);

    // Hapus token
    await ApiHandler.removeToken();

    return result.fold(
      (error) => Left(error),
      (data) => Right(data['message'] ?? 'Logout berhasil'),
    );
  }

  // Get profile user
  Future<Either<String, UserModel>> getProfile() async {
    final result = await ApiHandler.get(Variables.profile);

    return result.fold(
      (error) => Left(error),
      (data) => Right(UserModel.fromMap(data)),
    );
  }

  // Cek apakah user sudah login
  Future<bool> isLoggedIn() async {
    return ApiHandler.isLoggedId();
  }
}
