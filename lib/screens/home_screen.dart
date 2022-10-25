import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gg_docs/color.dart';
import 'package:gg_docs/repository/auth_repository.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void signOut(WidgetRef ref) {
    ref.read(authRepositoryProvider).signOut();
    ref.read(userProvider.notifier).update((state) => null);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add,color: kBlackColor,),
          ),
          IconButton(
            onPressed: () => signOut(ref),
            icon: const Icon(Icons.logout,color: kRedColor,),
          ),
        ],
      ),
      body: Center(
        child: Text(user!.token),
      ),
    );
  }
}
