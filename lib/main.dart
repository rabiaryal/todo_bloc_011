import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:todolist_011/bloc/todo_bloc.dart';
import 'package:todolist_011/model/datamodel.dart';
import 'package:todolist_011/view/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and Hive Flutter
  await Hive.initFlutter();

  // Register the TaskAdapter
  Hive.registerAdapter(TaskAdapter());

  // Open a box to store tasks
  await Hive.openBox<Task>('tasks');
  runApp(BlocProvider(
    create: (context) => TodoBloc(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Homepage(),
    );
  }
}
