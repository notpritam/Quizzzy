import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/constants/category_list.dart';
import 'package:quiz_app/pages/ProfileScreen.dart';

import 'package:quiz_app/routes/routesName.dart';

final category = StateProvider((ref) => "");
final level = StateProvider((ref) => "");

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    String? id = FirebaseAuth.instance.currentUser?.uid;
    final db = FirebaseFirestore.instance;
    final name = ref.watch(nameProvider);

    final dataMap = <String, String>{};

    final docRef = db.collection("users").doc(id);
    docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;

        ref.read(nameProvider.notifier).state = data['name'];
      },
      onError: (e) => print("Error getting document: $e"),
    );

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
        appBar: AppBar(
            title: Text("Quizzy"),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.format_quote_rounded)),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, profilePage);
                },
                icon: Icon(Icons.account_circle),
              ),
            ]),
        body: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Hey ${name},\nWhat subject you want to learn today",
                softWrap: true,
              ),
              Expanded(
                child: GridView.count(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  children: List.generate(10, (index) => SingleCategory(index)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SingleCategory extends ConsumerWidget {
  final int index;

  SingleCategory(this.index);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => {
        ref.read(category.notifier).state = CategoryList[index]['id'] as String,
        ref.read(level.notifier).state = "easy",
        Navigator.pushNamed(
          context,
          levelPage,
        ),
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.grey[200]),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                CategoryList[index]['img'] as String,
                height: 72,
                width: 72,
              ),
              SizedBox(
                height: 10,
              ),
              Text(CategoryList[index]['name'] as String),
            ],
          ),
        ),
      ),
    );
  }
}
