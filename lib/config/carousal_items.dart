import 'package:creditsea_flutter_assignment/config/assets.dart';
import 'package:creditsea_flutter_assignment/view/widget/custom_tile.dart';
import 'package:creditsea_flutter_assignment/view/widget/custom_top_container.dart';
import 'package:flutter/material.dart';

class CarousalItems {
  static final List<Widget> pages = [
    CustomTopContainer(
      title: "Flexible Loan Options",
      description: "Loan types to cater to different financial needs",
      mainContent: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        width: 200,
        height: 260,
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          children: [
            CustomTile(
              image: Assets.car,
              size: 80,
            ),
            CustomTile(
              image: Assets.bike,
              size: 80,
            ),
            CustomTile(
              image: Assets.laptop,
              size: 80,
            ),
            CustomTile(
              image: Assets.phone,
              size: 80,
            ),
          ],
        ),
      ),
    ),
    CustomTopContainer(
      title: "Instant Loan Approval",
      description: "Users will receive approval within minutes",
      mainContent: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        width: 200,
        child: CustomTile(image: Assets.bill, size: 200),
      ),
    ),
    CustomTopContainer(
      title: "24x7 Customer Care",
      description: "Dedicated customer support team",
      mainContent: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        width: 200,
        child: CustomTile(image: Assets.bill, size: 200),
      ),
    ),
  ];
}
