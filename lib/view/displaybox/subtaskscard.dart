import 'package:flutter/material.dart';

class SubTaskCard extends StatelessWidget {
  final String taskName;
  final String taskDescription;
  final bool isChecked;
  final ValueChanged<bool?> onCheckboxChanged;
  final VoidCallback onDelete;

  const SubTaskCard({
    super.key,
    required this.taskName,
    required this.taskDescription,
    required this.isChecked,
    required this.onCheckboxChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: isChecked,
        onChanged: onCheckboxChanged,
      ),
      title: Text(taskName),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
