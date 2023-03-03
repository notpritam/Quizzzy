import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/providers/auth_provider.dart';
import 'package:quiz_app/routes/routesName.dart';
import 'package:quiz_app/util/theme.dart';

final nameProvider = StateProvider<String>((ref) => "");
final wrongProvider = StateProvider<String>((ref) => "");
final correctquestionProvider = StateProvider<String>((ref) => "");
final totalquestionProvider = StateProvider<String>((ref) => "");
final levelProvider = StateProvider(
  (ref) => "Begginner",
);

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final name = ref.watch(nameProvider);
    final wrong = ref.watch(wrongProvider);
    final correct = ref.watch(correctquestionProvider);
    final totalQuestion = ref.watch(totalquestionProvider);
    String? id = FirebaseAuth.instance.currentUser?.uid;
    final db = FirebaseFirestore.instance;

    final dataMap = <String, String>{};

    final docRef = db.collection("users").doc(id);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        ref.read(nameProvider.notifier).state = data['name'];
        ref.read(wrongProvider.notifier).state = data['wrong'];
        ref.read(correctquestionProvider.notifier).state =
            data['correctquestion'];
        ref.read(totalquestionProvider.notifier).state =
            "${int.parse(wrong) + int.parse(correct)}";
      },
      onError: (e) => print("Error getting document: $e"),
    );

    final level = ref.watch(levelProvider);
    if (int.parse(correct) > 100 && int.parse(correct) < 200) {
      ref.read(levelProvider.notifier).state = "Learner";
    } else if (int.parse(correct) > 200 && int.parse(correct) < 500) {
      ref.read(levelProvider.notifier).state = "Dedicated";
    } else if (int.parse(correct) > 500) {
      ref.read(levelProvider.notifier).state = "Expert";
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Profile"),
      ),
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
        padding: EdgeInsets.all(20),
        child: SafeArea(
          child: Column(children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.black,
              child: Text("${int.parse(totalQuestion) / 20}"),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              name,
              style: headingStyle,
            ),
            Text(
              level,
              style: levelCaptionStyle,
            ),
            SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: Colors.white30),
                      gradient: const LinearGradient(
                        colors: [Colors.white60, Colors.white10],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                      )),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(correct, style: noStyle),
                                Text("Correct", style: captionStyle)
                              ],
                            ),
                            VerticalDivider(
                              color: Colors.grey.withOpacity(0.6),
                              thickness: 1,
                            ),
                            Column(
                              children: [
                                Text(wrong, style: noStyle),
                                Text("Wrong", style: captionStyle)
                              ],
                            ),
                            VerticalDivider(
                              color: Colors.grey.withOpacity(0.6),
                              thickness: 1,
                            ),
                            Column(
                              children: [
                                Text(totalQuestion, style: noStyle),
                                Text("Total", style: captionStyle)
                              ],
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                style: buttonTheme,
                onPressed: () {},
                child: Text("Contact Us")),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: buttonTheme,
              onPressed: () {
                ref.read(authRepositoryProvider).signOut();
                Navigator.pushNamed(context, loginPage);
              },
              child: Text("LogOut"),
            ),
          ]),
        ),
      ),
    );
  }
}
