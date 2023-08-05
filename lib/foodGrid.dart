import 'package:flutter/material.dart';

class foodGrid extends StatelessWidget {
  const foodGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: Colors.red,
        ),
      ),
    );
  }
}
