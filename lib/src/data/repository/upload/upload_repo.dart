import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../models/response_models/upload.dart';
import 'base_upload.dart';

class UploadRepository extends BaseUpload {
  UploadRepository(Dio dio) : _dio = dio;
  final Dio _dio;

  /// Removes an uploaded file using the installed file service
  @override
  Future<UserDeleteFileRes?> deleteFile({
    /// key of the file to delete
    required String fileKey,
    Map<String, dynamic>? customHeaders,
  }) async {
    try {
      if (customHeaders != null) {
        _dio.options.headers.addAll(customHeaders);
      }
      final response =
          await _dio.delete('/uploads', data: {'file_key': fileKey});
      if (response.statusCode == 200) {
        return UserDeleteFileRes.fromJson(response.data);
      } else {
        throw response;
      }
    } catch (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Creates a pre-signed download url for a file
  @override
  Future<UserGetFileUrlRes?> getFileUrl({
    /// key of the file to obtain the download link for
    required String fileKey,
    Map<String, dynamic>? customHeaders,
  }) async {
    try {
      if (customHeaders != null) {
        _dio.options.headers.addAll(customHeaders);
      }
      final response =
          await _dio.post('/uploads/download-url', data: {'file_key': fileKey});
      if (response.statusCode == 200) {
        return UserGetFileUrlRes.fromJson(response.data);
      } else {
        throw response;
      }
    } catch (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Uploads at least one file to the specific file service that is installed in Medusa.
  @override
  Future<UserUploadFileRes?> uploadFile({
    required List<File> files,
    Map<String, dynamic>? customHeaders,
  }) async {
    try {
      if (customHeaders != null) {
        _dio.options.headers.addAll(customHeaders);
      }
      _dio.options.headers.addAll({'Content-Type': 'image/jpeg'});

      List<MultipartFile> multipartFiles = [];

      for (var file in files) {
        String fileName = file.path.split(Platform.pathSeparator).last;
        multipartFiles
            .add(await MultipartFile.fromFile(file.path, filename: fileName));
      }

      FormData formData = FormData.fromMap({"files": multipartFiles});

      final response = await _dio.post('/uploads', data: formData);
      if (response.statusCode == 200) {
        return UserUploadFileRes.fromJson(response.data);
      } else {
        throw response;
      }
    } catch (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Uploads at least one file with ACL or a non-public bucket to the specific file service that is installed in Medusa.
  @override
  Future<UserUploadFileRes?> uploadProtectedFile({
    required List<String> files,
    Map<String, dynamic>? customHeaders,
  }) async {
    try {
      if (customHeaders != null) {
        _dio.options.headers.addAll(customHeaders);
      }
      final response =
          await _dio.post('/uploads/download-url', data: {'files': files});
      if (response.statusCode == 200) {
        return UserUploadFileRes.fromJson(response.data);
      } else {
        throw response;
      }
    } catch (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
      rethrow;
    }
  }
}