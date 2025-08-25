import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final String image;
  final double size;

  const CustomTile({
    super.key,
    required this.image,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      decoration: BoxDecoration(
          color: const Color.fromARGB(26, 255, 255, 255),
          borderRadius: BorderRadius.circular(15)),
      child: Image.asset(image),
    );
  }
}
