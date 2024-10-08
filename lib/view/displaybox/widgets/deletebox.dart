import 'package:flutter/material.dart';

class Deletebox extends StatelessWidget {
  final VoidCallback onDelete; // Callback for deletion

  const Deletebox({super.key, required this.onDelete}); // Constructor accepting the callback

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // Call the deletion callback when the button is pressed
        onDelete();
      },
      icon: const Icon(Icons.delete),
    );
  }
}
