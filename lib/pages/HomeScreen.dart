import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quiz_app/constants/category_list.dart';

import 'package:quiz_app/routes/routesName.dart';

final category = StateProvider((ref) => "");
final level = StateProvider((ref) => "");

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

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
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
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
        body: Container(
          padding: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                Color(0xFFFFCC70),
                Color(0xFFF2709C),
                Color(0xFFFF9472),
              ])),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: GridView.count(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      children:
                          List.generate(10, (index) => SingleCategory(index)),
                    ),
                  ),
                ],
              ),
            ),
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
      child: ClipRRect(
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
        ),
      ),
    );
  }
}
