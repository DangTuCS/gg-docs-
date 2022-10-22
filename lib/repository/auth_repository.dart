import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gg_docs/constants.dart';
import 'package:gg_docs/models/error_model.dart';
import 'package:gg_docs/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authRepositoryProvider = Provider(
        (ref) {
      var dio = Dio();
      dio.options.headers['content-Type'] =
      'application/json; charset=UTF-8';
      return AuthRepository(
        googleSignIn: GoogleSignIn(),
        dio: dio,
      );
    }
);

final userProvider = StateProvider<User?>((_) => null);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Dio _dio;

  const AuthRepository({
    required GoogleSignIn googleSignIn,
    required Dio dio,
  })  : _googleSignIn = googleSignIn,
        _dio = dio;

  Future<ErrorModel> signInWithGoogle() async {
    ErrorModel error =
    ErrorModel(error: 'Some unexpected error occurred', data: null);
    try {
      final user = await _googleSignIn.signIn();
      if (user != null) {
        final userAcc = User(
          name: user.displayName!,
          profilePic: user.photoUrl!,
          email: user.email,
          uid: '',
          token: '',
        );
        var res = await _dio.post(
          '$host/api/signup',
          data: userAcc.toJson(),
        );

        switch (res.statusCode) {
          case 200:
            final newUser =
            userAcc.copyWith(uid: res.data['user']['_id']);
            error = ErrorModel(
              error: null,
              data: newUser,
            );
            break;
          default:
            throw 'Some error';
        }
      }
    } catch (e) {
      error = ErrorModel(
        error: e.toString(),
        data: null,
      );
    }
    return error;
  }
}