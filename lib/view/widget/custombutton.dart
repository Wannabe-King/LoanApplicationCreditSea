import 'package:creditsea_flutter_assignment/config/color.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;
  final bool disabled;
  final Color background;

  const CustomButton({
    super.key,
    this.onTap,
    required this.buttonText,
    required this.disabled,
    this.background = ColorX.buttonBlue,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? onTap : null,
      child: Container(
        decoration: BoxDecoration(
          border: background == ColorX.buttonBlue
              ? null
              : Border.all(
                  color: ColorX.buttonBlue,
                  width: 2,
                ),
          color: disabled ? background : ColorX.darkGrey,
          borderRadius: BorderRadius.circular(5),
          boxShadow: background == ColorX.buttonBlue
              ? [
                  BoxShadow(
                    color: const Color.fromARGB(127, 0, 119, 255),
                    spreadRadius: 1,
                    blurRadius: 15,
                  )
                ]
              : null,
        ),
        padding: EdgeInsets.all(14),
        width: MediaQuery.of(context).size.width * 0.95,
        child: Center(
            child: Text(
          buttonText,
          style: TextStyle(
              color:
                  background == ColorX.buttonBlue ? ColorX.white : Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w500),
        )),
      ),
    );
  }
}
