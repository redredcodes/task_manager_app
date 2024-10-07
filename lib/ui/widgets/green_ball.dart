import 'package:flutter/material.dart';

class GreenBall extends StatelessWidget {
  const GreenBall({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 350,
      decoration: const BoxDecoration(
        color: Colors.green,
        shape: BoxShape.circle,
      ),
    );
  }
}
