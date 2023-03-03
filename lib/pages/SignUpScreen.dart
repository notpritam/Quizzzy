import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/constants/image_strings.dart';

import 'package:quiz_app/providers/auth_provider.dart';
import 'package:quiz_app/routes/routesName.dart';
import 'package:quiz_app/util/theme.dart';

class SignUpScreen extends ConsumerWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Color(0xFFFFCC70),
              Color(0xFFC850C0),
              Color(0xFF4158D0),
            ])),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(children: [
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
                height: 10,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "Sign Up",
                  style: headingStyle,
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
                  decoration: InputDecoration(label: Text("Password")),
                  keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: ElevatedButton.icon(
                      style: formButtonTheme,
                      onPressed: () async {
                        if (nameController.text.isNotEmpty &&
                            emailController.text.length > 8 &&
                            emailController.text.contains("@")) {
                          if (passwordController.text.length > 8) {
                            final String message = await ref
                                .read(authRepositoryProvider)
                                .createUser(
                                    emailController.text.trim(),
                                    passwordController.text.trim(),
                                    nameController.text);

                            if (message == "User created successfully") {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text(
                                        message,
                                      )));
                              Navigator.pushNamed(context, checkAuth);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(message)));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Choose a strong passoword")));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Fill the details")));
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
                      Navigator.pushNamed(context, loginPage);
                    },
                    child: Center(child: Text("Sign In")))
              ]),
            ]),
          ),
        ),
      ),
    );
  }
}
