import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  void _showExportDialog(BuildContext context, AppDatabase db) async {
    final data = await db.exportAllData();
    final jsonString = const JsonEncoder.withIndent('  ').convert(data);

    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Data'),
        content: SizedBox(
          width: double.maxFinite,
          height: 400,
          child: SingleChildScrollView(
            child: SelectableText(
              jsonString,
              style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: jsonString));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Copied to clipboard!')),
              );
            },
            child: const Text('Copy to Clipboard'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final AppDatabase db = ref.read(databaseProvider);
      return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: const Icon(Icons.download),
                  tooltip: 'Export Data',
                  onPressed: () => _showExportDialog(context, db),
                ),
              ],
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
