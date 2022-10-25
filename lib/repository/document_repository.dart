import 'package:dio/dio.dart';
import 'package:gg_docs/models/document_model.dart';

import '../constants.dart';
import '../models/error_model.dart';

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
      var res = await _dio.post('$host/', data: {
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
      }
    } catch (e) {
      error.copyWith(
        error: e.toString(),
      );
    }
    return error;
  }
}
