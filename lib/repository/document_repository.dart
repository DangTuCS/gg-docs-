import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gg_docs/models/document_model.dart';

import '../constants.dart';
import '../models/error_model.dart';

final documentRepositoryProvider = Provider(
  (ref) => DocumentRepository(
    dio: Dio(),
  ),
);

class DocumentRepository {
  final Dio _dio;

  const DocumentRepository({
    required Dio dio,
  }) : _dio = dio;

  Future<ErrorModel> createDocument(String token) async {
    ErrorModel error = ErrorModel(
      error: "Some error occurred!",
      data: null,
    );
    try {
      _dio.options.headers = {
        'Content-type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      };
      var res = await _dio.post('$host/doc/create', data: {
        'createdAt': DateTime.now().millisecondsSinceEpoch,
      });
      switch (res.statusCode) {
        case 200:
          error = ErrorModel(
            error: null,
            data: DocumentModel.fromJson(
              res.data,
            ),
          );
          break;
        default:
          error = ErrorModel(
            error: res.data,
            data: null,
          );
          break;
      }
    } catch (e) {
      error.copyWith(
        error: e.toString(),
      );
    }
    return error;
  }

  void updateTitle({
    required String token,
    required String id,
    required String title,
  }) async {
    _dio.options.headers = {
      'Content-type': 'application/json; charset=UTF-8',
      'x-auth-token': token,
    };
    var res = await _dio.post('$host/doc/title', data: {
      'id': id,
      'title': title,
    });
  }

  Future<ErrorModel> getDocuments(String token) async {
    ErrorModel error = ErrorModel(
      error: "Some error occurred!",
      data: null,
    );
    try {
      _dio.options.headers = {
        'Content-type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      };
      var res = await _dio.get('$host/docs/me');
      switch (res.statusCode) {
        case 200:
          List<DocumentModel> documents = [];
          for (int i = 0; i < res.data.length; i++) {
            DocumentModel documentModel = DocumentModel.fromJson(res.data[i]);
            documents.add(documentModel);
          }
          error = ErrorModel(
            error: null,
            data: documents,
          );
          break;
        default:
          error = ErrorModel(
            error: res.data,
            data: null,
          );
          break;
      }
    } catch (e) {
      error.copyWith(
        error: e.toString(),
      );
    }
    return error;
  }

  Future<ErrorModel> getDocumentById({
    required String token,
    required String id,
  }) async {
    ErrorModel error = ErrorModel(
      error: "Some error occurred!",
      data: null,
    );
    try {
      _dio.options.headers = {
        'Content-type': 'application/json; charset=UTF-8',
        'x-auth-token': token,
      };
      var res = await _dio.get('$host/doc/$id');
      switch (res.statusCode) {
        case 200:
          DocumentModel document = DocumentModel.fromJson(res.data);
          error = ErrorModel(
            error: null,
            data: document,
          );
          break;
        default:
          throw 'This Document does not exist, please create a new one';
      }
    } catch (e) {
      print(e.toString());
      error.copyWith(
        error: e.toString(),
      );
    }
    return error;
  }
}
