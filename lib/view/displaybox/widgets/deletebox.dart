import 'package:flutter/material.dart';

class Deletebox extends StatelessWidget {
  final VoidCallback onDelete;

  const Deletebox({super.key, required this.onDelete}); 

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        
        onDelete();
      },
      icon: const Icon(Icons.delete),
    );
  }
}
