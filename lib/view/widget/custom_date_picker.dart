import 'package:creditsea_flutter_assignment/config/color.dart';
import 'package:creditsea_flutter_assignment/controllers/personal_detail_controller.dart';
import 'package:creditsea_flutter_assignment/view/widget/custom_input_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDatePickerField extends StatefulWidget {
  final String hintText;
  final Function(DateTime)? onDateSelected;

  const CustomDatePickerField({
    super.key,
    required this.hintText,
    this.onDateSelected,
  });

  static const inputBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: ColorX.darkGrey,
      width: 1.0,
    ),
  );

  @override
  State<CustomDatePickerField> createState() => _CustomDatePickerFieldState();
}

class _CustomDatePickerFieldState extends State<CustomDatePickerField> {
  DateTime? selectedDate;
  final PersonalDetailController personalDetailController =
      Get.find<PersonalDetailController>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      personalDetailController.pickDob(picked);
      setState(() {
        selectedDate = picked;
      });
      if (widget.onDateSelected != null) {
        widget.onDateSelected!(picked);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomInputContainer(
      inputTitle: "Date of Birth*",
      inputWidget: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          border: CustomDatePickerField.inputBorder,
          enabledBorder: CustomDatePickerField.inputBorder,
          focusedBorder: CustomDatePickerField.inputBorder,
          hintText: selectedDate != null
              ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
              : widget.hintText,
          hintStyle: const TextStyle(fontSize: 18),
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context),
          ),
        ),
        onTap: () => _selectDate(context),
      ),
    );
  }
}
