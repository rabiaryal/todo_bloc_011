import 'package:flutter/material.dart';

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
    _subTaskControllers.add(TextEditingController()); // Add at least one input field initially
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 8),
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
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                hintText: 'Enter sub-task',
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _removeSubTaskField(index);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              TextButton(
                onPressed: _addSubTaskField,
                child: const Text('Add another sub-task'),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Collect the sub-tasks and return them to the previous screen
          List<String> subTasks = _subTaskControllers
              .map((controller) => controller.text)
              .where((text) => text.isNotEmpty)
              .toList();
          Navigator.pop(context, subTasks); // Pass the list of sub-tasks back
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
