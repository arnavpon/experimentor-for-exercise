import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ExerciseMentor/models/database.dart';
import 'package:ExerciseMentor/providers.dart';
import 'package:ExerciseMentor/views/widgets/logger_form.dart';
import 'package:ExerciseMentor/views/widgets/visualizer.dart';
import 'package:ExerciseMentor/views/widgets/workout_summary.dart';

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
                  Tab(icon: Icon(Icons.note_add)),
                  Tab(icon: Icon(Icons.today)),
                  Tab(icon: Icon(Icons.history)),
                ],
              ),
            ),
            body: TabBarView(children: [
              LoggerForm(db),
              WorkoutSummaryWidget(db),
              VisualizerWidget(db),
            ]),
          ));
    });
  }
}
