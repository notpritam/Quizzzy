import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/providers/auth_provider.dart';
import 'package:quiz_app/routes/routesName.dart';

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
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.black,
            child: Text("${int.parse(totalQuestion) / 20}"),
          ),
          SizedBox(
            height: 10,
          ),
          Text(name),
          Text(level),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20)),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [Text(correct), Text("Correct")],
                      ),
                      VerticalDivider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                      Column(
                        children: [Text(wrong), Text("Wrong")],
                      ),
                      VerticalDivider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                      Column(
                        children: [
                          Text(totalQuestion),
                          Text("Total Questions")
                        ],
                      ),
                    ]),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: () {}, child: Text("Contact Us")),
          ElevatedButton(
            onPressed: () {
              ref.read(authRepositoryProvider).signOut();
              Navigator.pushNamed(context, loginPage);
            },
            child: Text("LogOut"),
          ),
        ]),
      ),
    );
  }
}
