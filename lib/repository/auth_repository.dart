import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gg_docs/constants.dart';
import 'package:gg_docs/models/error_model.dart';
import 'package:gg_docs/models/user_model.dart';
import 'package:gg_docs/repository/local_storage_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    googleSignIn: GoogleSignIn(),
    dio: Dio(),
    localStorageRepository: LocalStorageRepository(),
  ),
);

final userProvider = StateProvider<User?>((_) => null);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Dio _dio;
  final LocalStorageRepository _localStorageRepository;

  AuthRepository({
    required GoogleSignIn googleSignIn,
    required Dio dio,
    required LocalStorageRepository localStorageRepository,
  })  : _googleSignIn = googleSignIn,
        _dio = dio,
        _localStorageRepository = localStorageRepository;

  Future<ErrorModel> signInWithGoogle() async {
    ErrorModel error =
        ErrorModel(error: 'Some unexpected error occurred', data: null);
    try {
      final user = await _googleSignIn.signIn();
      if (user != null) {
        final userAcc = User(
          name: user.displayName ?? '',
          profilePic: user.photoUrl ?? '',
          email: user.email,
          uid: '',
          token: '',
        );

        _dio.options.headers['content-Type'] =
            'application/json; charset=UTF-8';

        var res = await _dio.post(
          '$host/api/signup',
          data: userAcc.toJson(),
        );

        print('sign up: ${res.data}');

        switch (res.statusCode) {
          case 200:
            final newUser = userAcc.copyWith(
              uid: res.data['user']['_id'],
              token: res.data['token'],
            );
            error = ErrorModel(
              error: null,
              data: newUser,
            );
            _localStorageRepository.setToken(newUser.token);
            break;
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

  Future<ErrorModel> getUserData() async {
    ErrorModel error = ErrorModel(
      error: 'Some unexpected error occurred',
      data: null,
    );

    try {
      String? token = await _localStorageRepository.getToken();
      if (token != null) {
        _dio.options.headers = {
          'Content-type': 'application/json; charset=UTF-8',
          'x-auth-token': token,
        };
        var res = await _dio.get('$host/');
        switch (res.statusCode) {
          case 200:
            final userAcc =
                User.fromJson(res.data);
            error = ErrorModel(
              error: null,
              data: userAcc,
            );
            _localStorageRepository.setToken(userAcc.token);
            break;
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

  void signOut() async {
    await _googleSignIn.signOut();
    _localStorageRepository.setToken('');
  }
}
