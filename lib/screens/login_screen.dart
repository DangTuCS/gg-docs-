import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gg_docs/color.dart';
import 'package:gg_docs/repository/auth_repository.dart';
import 'package:gg_docs/screens/home_screen.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  void singInWithGoogle(BuildContext context, WidgetRef ref) async {
    final sMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final errorModel =
        await ref.read(authRepositoryProvider).signInWithGoogle();
    if (errorModel.error != null) {
      print(errorModel.error);
      sMessenger.showSnackBar(
        SnackBar(
          content: Text(errorModel.error!),
        ),
      );
    } else {
      ref.read(userProvider.notifier).update(
            (state) => errorModel.data,
          );
      navigator.push(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => singInWithGoogle(context, ref),
          icon: Image.asset(
            'assets/images/g-logo-2.png',
            height: 20,
          ),
          label: const Text(
            'Sign in with Google',
            style: TextStyle(color: kBlackColor),
          ),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(150, 50),
            backgroundColor: kWhiteColor,
          ),
        ),
      ),
    );
  }
}
