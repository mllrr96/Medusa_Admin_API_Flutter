import 'dart:developer';
import 'package:dio/dio.dart';
import 'base_user.dart';
import '../../models/index.dart';

class UserRepository extends BaseUser {
  UserRepository(Dio dio) : _dio = dio;
  final Dio _dio;
  static const _users = '/users';

  @override
  Future<User?> create({
    required UserCreateUserReq userCreateUserReq,
    Map<String, dynamic>? customHeaders,
  }) async {
    if (customHeaders != null) {
      _dio.options.headers.addAll(customHeaders);
    }
    try {
      final response = await _dio.post(
        _users,
        data: userCreateUserReq.toJson(),
      );
      if (response.statusCode == 200) {
        return User.fromJson(response.data['user']);
      } else {
        throw response;
      }
    } catch (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<UserDeleteUserRes?> delete({
    required String id,
    Map<String, dynamic>? customHeaders,
  }) async {
    if (customHeaders != null) {
      _dio.options.headers.addAll(customHeaders);
    }
    try {
      final response = await _dio.delete(
        '$_users/$id',
      );
      if (response.statusCode == 200) {
        return UserDeleteUserRes.fromJson(response.data);
      } else {
        throw response;
      }
    } catch (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<bool?> requestPasswordReset({
    required String email,
    Map<String, dynamic>? customHeaders,
  }) async {
    if (customHeaders != null) {
      _dio.options.headers.addAll(customHeaders);
    }
    try {
      final response = await _dio.post(
        '$_users/password-token',
        data: {'email': email},
      );
      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        throw response;
      }
    } catch (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<User?> resetPassword({
    required UserResetPasswordReq userResetPasswordReq,
    Map<String, dynamic>? customHeaders,
  }) async {
    if (customHeaders != null) {
      _dio.options.headers.addAll(customHeaders);
    }
    try {
      final response = await _dio.post(
        '$_users/reset-password',
        data: userResetPasswordReq.toJson(),
      );
      if (response.statusCode == 200) {
        return User.fromJson(response.data['user']);
      } else {
        throw response;
      }
    } catch (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<User?> retrieve({
    required String id,
    Map<String, dynamic>? customHeaders,
  }) async {
    if (customHeaders != null) {
      _dio.options.headers.addAll(customHeaders);
    }
    try {
      final response = await _dio.get(
        '$_users/$id',
      );
      if (response.statusCode == 200) {
        return User.fromJson(response.data['user']);
      } else {
        throw response;
      }
    } catch (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<UserRetrieveUserListRes?> retrieveAll(
      {Map<String, dynamic>? customHeaders,
      Map<String, dynamic>? queryParameters}) async {
    if (customHeaders != null) {
      _dio.options.headers.addAll(customHeaders);
    }
    try {
      final response = await _dio.get(
        _users,
        queryParameters: queryParameters,
      );
      if (response.statusCode == 200) {
        return UserRetrieveUserListRes.fromJson(response.data);
      } else {
        throw response;
      }
    } catch (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
      rethrow;
    }
  }

  @override
  Future<User?> update({
    required String id,
    required UserUpdateUserReq userUpdateUserReq,
    Map<String, dynamic>? customHeaders,
  }) async {
    if (customHeaders != null) {
      _dio.options.headers.addAll(customHeaders);
    }
    try {
      final response = await _dio.post(
        '$_users/$id',
        data: userUpdateUserReq.toJson(),
      );
      if (response.statusCode == 200) {
        return User.fromJson(response.data['user']);
      } else {
        throw response;
      }
    } catch (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
      rethrow;
    }
  }
}
