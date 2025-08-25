import 'package:creditsea_flutter_assignment/config/color.dart';
import 'package:flutter/material.dart';

class StatusTile extends StatelessWidget {
  final String status;
  final bool done;
  final Color? color;
  const StatusTile({
    super.key,
    required this.status,
    required this.done,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border:
            Border.all(color: done ? ColorX.green : color ?? ColorX.darkGrey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
          child: Text(
        status,
        style: TextStyle(
          fontSize: 15,
          color: done ? ColorX.green : color ?? ColorX.darkGrey,
        ),
      )),
    );
  }
}
