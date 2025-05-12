import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const GradientText(this.text, {super.key, required this.style});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [
          Color.fromARGB(255, 251, 108, 173),
          Color.fromARGB(255, 209, 106, 199),
          Color.fromARGB(255, 190, 105, 210),
          Color.fromARGB(255, 149, 103, 235),
          Color.fromARGB(255, 115, 102, 255),
          Color.fromARGB(255, 115, 102, 255),
          Color.fromARGB(255, 115, 102, 255)
        ], // Gradient colors
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        text,
        //softWrap: true,
        //maxLines: 2,
        //overflow: TextOverflow.ellipsis,
        style: style.copyWith(
            color: Colors.white), // Text color must be white for ShaderMask
      ),
    );
  }
}