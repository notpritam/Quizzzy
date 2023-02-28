import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/constants/image_strings.dart';
import 'package:quiz_app/pages/LoginScreen.dart';
import 'package:quiz_app/providers/auth_provider.dart';
import 'package:quiz_app/util/auth_checker.dart';

class SignUpScreen extends ConsumerWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                    signupHeader,
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
                              "Sign Up",
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(label: Text("Name")),
                              keyboardType: TextInputType.name,
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
                                    ref.read(authRepositoryProvider).createUser(
                                        emailController.text.trim(),
                                        passwordController.text.trim());
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AuthChecker()));
                                    try {} catch (e) {
                                      print("error");
                                    }
                                  },
                                  icon: Icon(Icons.abc),
                                  label: Text("Next")),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                                },
                                child: Text("Sign In"))
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
