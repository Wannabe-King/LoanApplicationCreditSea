import 'package:creditsea_flutter_assignment/config/color.dart';
import 'package:flutter/material.dart';

class ProgressContainer extends StatelessWidget {
  final int selectedIndex;

  const ProgressContainer({super.key, required this.selectedIndex});

  Widget _buildStep(int index, String title) {
    final isSelected = index == selectedIndex;
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isSelected
                ? ColorX.buttonBlue
                : const Color.fromARGB(29, 117, 117, 117),
          ),
          child: Center(
            child: Text(
              "$index",
              style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? Colors.white : Colors.black),
            ),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: isSelected ? ColorX.buttonBlue : ColorX.grey,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStep(1, "Register"),
        _buildStep(2, "Offer"),
        _buildStep(3, "Approval"),
      ],
    );
  }
}
