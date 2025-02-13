import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'views/screens/home_screen.dart';

void main() async {
  runApp(ProviderScope(
    child: MyApp(),
  )); // expose app to riverpod
}

class MyApp extends ConsumerWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Exercise Companion',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blueGrey,
      ),
      home: HomeScreen(),
    );
  }
}
