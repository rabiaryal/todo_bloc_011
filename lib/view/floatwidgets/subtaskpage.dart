import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_011/bloc/todo_bloc.dart'; // Import your BLoC

class SubTaskPage extends StatefulWidget {
  const SubTaskPage({super.key});

  @override
  _SubTaskPageState createState() => _SubTaskPageState();
}

class _SubTaskPageState extends State<SubTaskPage> {
  List<TextEditingController> _subTaskControllers = [];

  @override
  void initState() {
    super.initState();
    _subTaskControllers.add(TextEditingController()); // Add an initial field
  }

  @override
  void dispose() {
    _subTaskControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _addSubTaskField() {
    setState(() {
      _subTaskControllers.add(TextEditingController());
    });
  }

  void _removeSubTaskField(int index) {
    setState(() {
      _subTaskControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Sub-tasks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _subTaskControllers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _subTaskControllers[index],
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Sub-task',
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => _removeSubTaskField(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final subTasks = _subTaskControllers
                    .map((controller) => controller.text)
                    .where((text) => text.isNotEmpty)
                    .toList();
                Navigator.of(context).pop(subTasks);
              },
              child: const Text('Save Sub-tasks'),
            ),
            TextButton(
              onPressed: _addSubTaskField,
              child: const Text('Add Another Sub-task'),
            ),
          ],
        ),
      ),
    );
  }
}
