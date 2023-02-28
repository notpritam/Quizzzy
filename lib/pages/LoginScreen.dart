import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/constants/image_strings.dart';
import 'package:quiz_app/pages/SignUpScreen.dart';
import 'package:quiz_app/providers/auth_provider.dart';
import 'package:quiz_app/repository/auth_repo.dart';
import 'package:quiz_app/util/auth_checker.dart';

class LoginScreen extends ConsumerWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    return Stack(
      children: [
        SvgPicture.asset(
          splashBgImage2,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(children: [
              Center(
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: SvgPicture.asset(
                    loginHeader,
                    width: double.infinity,
                    height: 250,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 7,
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Login",
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(label: Text("Email")),
                              keyboardType: TextInputType.emailAddress,
                            ),
                            TextFormField(
                              controller: passwordController,
                              decoration:
                                  InputDecoration(label: Text("Password")),
                              keyboardType: TextInputType.visiblePassword,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: ElevatedButton.icon(
                                  onPressed: () {
                                    try {
                                      ref
                                          .read(authRepositoryProvider)
                                          .signInWithEmailAndPassword(
                                              emailController.text.trim(),
                                              passwordController.text.trim());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AuthChecker()));
                                    } catch (e) {
                                      print("Error");
                                    }
                                  },
                                  icon: Icon(Icons.abc),
                                  label: Text("Next")),
                            ),
                            GestureDetector(
                                onTap: () => {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (contex) =>
                                                  SignUpScreen()))
                                    },
                                child: Text("Sign Up")),
                          ]),
                    ),
                  ),
                ),
              )
            ]),
          ),
        )
      ],
    );
  }
}
