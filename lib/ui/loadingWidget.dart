import 'package:flutter/material.dart';

class GetLoad extends StatelessWidget {
  final String text;
  const GetLoad({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,

      children: [

        Text(text),
        const SizedBox(width: 10),
        const CircularProgressIndicator(color: Colors.red)

      ],
    );
  }
}
