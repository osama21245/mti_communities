import 'package:mti_communities/core/common/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/common/sign_in_button.dart';
import '../../../core/constants/constants.dart';
import '../../home/screens/home_screen.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  void signInAsGuest(BuildContext context, WidgetRef ref) async {
    ref.read(authControllerProvider.notifier).signInAsGuest(context);
    SharedPreferences prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isloading = ref.watch(authControllerProvider);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/game-logo-5-veed-remove-background-1-mSJ.png",
          height: 55,
        ),
        actions: [
          TextButton(
            onPressed: () => signInAsGuest(context, ref),
            child: const Text(
              'Skip',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: isloading
          ? const Loader()
          : Column(
              children: [
                SizedBox(height: size.height * 0.05),
                const Text(
                  'Dive into anything',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: size.height * 0.08),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    Constants.loginEmotePath,
                    width: size.width * 0.9,
                  ),
                ),
                SizedBox(height: size.height * 0.06),
                SignInButton(),
              ],
            ),
    );
  }
}
