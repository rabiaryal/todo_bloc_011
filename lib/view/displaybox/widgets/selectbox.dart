import 'package:flutter/material.dart';

class SelectBox extends StatefulWidget {
  final bool isChecked;
  final ValueChanged<bool?> onChanged; 

  const SelectBox({
    super.key,
    required this.isChecked,
    required this.onChanged,
  });

  @override
  _SelectBoxState createState() => _SelectBoxState();
}

class _SelectBoxState extends State<SelectBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Transform.scale(
        scale: 1.5,
        child: Checkbox(
          value: widget.isChecked,
          onChanged: widget.onChanged,
          activeColor: Colors.black, 
        ),
      ),
    );
  }
}
