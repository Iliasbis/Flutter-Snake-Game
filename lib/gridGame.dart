import 'package:flutter/material.dart';


class gridGame extends StatelessWidget {
  const gridGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.grey.shade800,
                        ),
                      ),
                    );
  }
}