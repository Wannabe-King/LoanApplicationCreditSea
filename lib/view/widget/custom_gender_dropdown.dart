import 'package:creditsea_flutter_assignment/config/color.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String? selectedGender;
  final Function(String?)? onChanged;
  final List<String> options;
  final String hintText;

  const CustomDropdown({
    super.key,
    this.selectedGender,
    this.onChanged,
    required this.options,
    required this.hintText,
  });

  static const inputBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: ColorX.darkGrey,
      width: 1.0,
    ),
  );

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedGender;

  @override
  void initState() {
    super.initState();
    selectedGender = widget.selectedGender;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      icon: Icon(Icons.keyboard_arrow_down),
      value: selectedGender,
      decoration: InputDecoration(
        border: CustomDropdown.inputBorder,
        enabledBorder: CustomDropdown.inputBorder,
        focusedBorder: CustomDropdown.inputBorder,
        errorBorder: CustomDropdown.inputBorder,
        hintText: widget.hintText,
        hintStyle: TextStyle(fontSize: 18),
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
      ),
      items: widget.options
          .map((gender) => DropdownMenuItem(
                value: gender,
                child: Text(
                  gender,
                  style: const TextStyle(fontSize: 18),
                ),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedGender = value;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
    );
  }
}
