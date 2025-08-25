import 'package:creditsea_flutter_assignment/controllers/personal_detail_controller.dart';
import 'package:creditsea_flutter_assignment/view/widget/custom_date_picker.dart';
import 'package:creditsea_flutter_assignment/view/widget/custom_gender_dropdown.dart';
import 'package:creditsea_flutter_assignment/view/widget/custom_input_container.dart';
import 'package:creditsea_flutter_assignment/view/widget/custom_input_field.dart';
import 'package:creditsea_flutter_assignment/view/widget/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final PersonalDetailController personalDetailController =
      Get.find<PersonalDetailController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.arrow_back),
            SizedBox(
              width: 20,
            ),
            Text(
              "Personal Details",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomInputContainer(
                width: 170,
                inputTitle: "First Name*",
                inputWidget: CustomInputField(
                    controller: firstNameController,
                    hintText: "First Name",
                    password: false)),
            CustomInputContainer(
                width: 170,
                inputTitle: "Last Name*",
                inputWidget: CustomInputField(
                    controller: lastNameController,
                    hintText: "Last Name",
                    password: false)),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        CustomInputContainer(
          inputTitle: "Gender*",
          inputWidget: CustomDropdown(
            onChanged: (value) {
              if (value != null) {
                personalDetailController.gender.value = value;
              }
            },
            hintText: "Select your gender",
            options: ["Male", "Female", "Others"],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        CustomDatePickerField(hintText: "DD - MM - YYYY"),
        SizedBox(
          height: 20,
        ),
        CustomInputContainer(
          inputTitle: "Your Marital Status *",
          inputWidget: CustomDropdown(
            onChanged: (value) {
              if (value != null) {
                personalDetailController.maritialStatus.value = value;
              }
            },
            hintText: "Select",
            options: ["Married", "Single", "Happy"],
          ),
        ),
        Spacer(),
        CustomButton(
          buttonText: "Continue",
          disabled: true,
          onTap: () {
            personalDetailController.firstName.value = firstNameController.text;
            personalDetailController.lastName.value = lastNameController.text;
            if (personalDetailController.validateInputs()) {
              personalDetailController.switchScreen(PersonalDetailScreen.email);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:
                      Text("Please fill all the field before moving forward")));
            }
          },
        )
      ],
    );
  }
}
