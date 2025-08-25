import 'package:client_app/config/assets.dart';
import 'package:client_app/controllers/personal_detail_controller.dart';
import 'package:client_app/view/pages/dashboard_page.dart';
import 'package:client_app/view/screens/applyforloan.dart';
import 'package:client_app/view/widget/custom_input_container.dart';
import 'package:client_app/view/widget/custom_input_field.dart';
import 'package:client_app/view/widget/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PanDetail extends StatefulWidget {
  const PanDetail({super.key});

  @override
  State<PanDetail> createState() => _PanDetailState();
}

class _PanDetailState extends State<PanDetail> {
  final TextEditingController panController = TextEditingController();
  final PersonalDetailController personalDetailController =
      Get.find<PersonalDetailController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => personalDetailController.switchScreen(
                PersonalDetailScreen.email,
              ),
            ),
            SizedBox(width: 20),
            Text(
              "Verify PAN Number",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        SizedBox(height: 40),
        Image.asset(Assets.creditcard),
        SizedBox(height: 40),
        CustomInputContainer(
          inputTitle: "Enter Your PAN Number*",
          inputWidget: CustomInputField(
            controller: panController,
            hintText: "e.g., ABCDE1234F",
            password: false,
          ),
        ),
        Spacer(),
        CustomButton(
          buttonText: "Verify",
          disabled: true,
          onTap: () {
            if (panController.text != '') {
              final bool panValid = RegExp(
                r"^[a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}",
              ).hasMatch(panController.text);
              if (panValid) {
                personalDetailController.pan.value = panController.text
                    .toUpperCase();

                personalDetailController.updateUserDetail(context);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => DashboardPage()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Please enter a valid pan.")),
                );
              }
            } else {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Please enter pan.")));
            }
          },
        ),
      ],
    );
  }
}
