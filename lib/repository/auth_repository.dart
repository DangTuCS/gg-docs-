import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gg_docs/constants.dart';
import 'package:gg_docs/models/error_model.dart';
import 'package:gg_docs/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    googleSignIn: GoogleSignIn(),
    client: Client(),
  ),
);

final userProvider = StateProvider<User?>((_) => null);

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final Client _client;

  const AuthRepository({
    required GoogleSignIn googleSignIn,
    required Client client,
  })  : _googleSignIn = googleSignIn,
        _client = client;

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

        print(userAcc.toJson());

        var res = await _client.post(
          Uri.parse('$host/api/signup'),
          body: json.encode(userAcc.toJson()),
          headers: {
            "Access-Control-Allow-Methods": "GET, HEAD",
            "Access-Control-Allow-Origin": "*",
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': '*/*'
          },
        );

        print(res);

        switch (res.statusCode) {
          case 200:
            final newUser =
                userAcc.copyWith(uid: jsonDecode(res.body)['user']['_id']);
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
