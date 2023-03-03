import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/constants/image_strings.dart';

import 'package:quiz_app/providers/auth_provider.dart';

import 'package:quiz_app/routes/routesName.dart';
import 'package:quiz_app/util/theme.dart';

class LoginScreen extends ConsumerWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, ref) {
    Future<bool> _onWillPop() async {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Do you want to close the App'),
              actions: <Widget>[
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(false), //<-- SEE HERE
                  child: new Text('No'),
                ),
                TextButton(
                  onPressed: () => SystemNavigator.pop(), // <-- SEE HERE
                  child: new Text('Yes'),
                ),
              ],
            ),
          )) ??
          false;
    }

    return WillPopScope(
      onWillPop: () {
        return _onWillPop();
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Container(
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
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(25),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        loginHeader,
                        height: 250,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Login",
                        style: headingStyle,
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
                              if (emailController.text.length > 8 &&
                                  emailController.text.contains("@") &&
                                  passwordController.text.length > 8) {
                                String message = await ref
                                    .read(authRepositoryProvider)
                                    .signInWithEmailAndPassword(
                                        emailController.text.trim(),
                                        passwordController.text.trim());
                                if (message == "Login Successful") {
                                  Navigator.pushNamed(context, checkAuth);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(message)));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor: Colors.red,
                                        content: const Text(
                                            "Enter a valid email & password")));
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
                            Navigator.pushNamed(context, signUpPage);
                          },
                          child: Container(
                            child: Text("Sign Up"),
                          )),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
