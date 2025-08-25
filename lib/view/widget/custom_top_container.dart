import 'package:creditsea_flutter_assignment/config/assets.dart';
import 'package:creditsea_flutter_assignment/config/color.dart';
import 'package:flutter/material.dart';

class CustomTopContainer extends StatelessWidget {
  final Widget mainContent;
  final String title;
  final String description;

  const CustomTopContainer({
    super.key,
    required this.mainContent,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(Assets.logo),
        mainContent,
        Text(
          title,
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
            color: ColorX.white,
          ),
        ),
        Text(
          description,
          style: TextStyle(
              fontSize: 15,
              color: ColorX.lightGrey,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
