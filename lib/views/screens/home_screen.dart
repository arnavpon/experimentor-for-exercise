import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/models/database.dart';
import 'package:test/providers.dart';
import 'package:test/views/widgets/logger_form.dart';
import 'package:test/views/widgets/visualizer.dart';
import 'package:test/views/widgets/workout_summary.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final AppDatabase db = ref.read(databaseProvider);
      return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.login)),
                  Tab(icon: Icon(Icons.note)),
                  Tab(icon: Icon(Icons.fitness_center)),
                ],
              ),
            ),
            body: TabBarView(children: [
              LoggerForm(db),
              WorkoutSummaryWidget(db),
              VisualizerWidget(db),
            ]), // This trailing comma makes auto-formatting nicer for build methods.
          ));
    });
  }
}
