
import 'package:flutter/material.dart';

class ColumnText extends StatelessWidget {
  const ColumnText({super.key, required this.text1, required this.text2});

  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w700
          ),
        ),
        Divider(
          endIndent: 10,
          thickness: .7,
          color: Colors.grey.shade400,
        ),
        Text(
          text2,
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
