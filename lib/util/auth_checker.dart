import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/pages/HomeScreen.dart';
import 'package:quiz_app/pages/LoginScreen.dart';
import 'package:quiz_app/pages/SplashScreen.dart';
import 'package:quiz_app/providers/auth_provider.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authState = ref.watch(authStateProvider);

    return _authState.when(
        data: (user) {
          if (user != null) return const HomeScreen();
          return LoginScreen();
        },
        error: (e, trace) => LoginScreen(),
        loading: () => const SplashScreen());
  }
}
