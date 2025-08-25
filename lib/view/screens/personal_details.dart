import 'package:creditsea_flutter_assignment/config/color.dart';
import 'package:creditsea_flutter_assignment/controllers/personal_detail_controller.dart';
import 'package:creditsea_flutter_assignment/view/screens/email_verification.dart';
import 'package:creditsea_flutter_assignment/view/screens/name_screen.dart';
import 'package:creditsea_flutter_assignment/view/screens/pan_detail.dart';
import 'package:creditsea_flutter_assignment/view/widget/progress_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalDetail extends StatefulWidget {
  const PersonalDetail({super.key});

  @override
  State<PersonalDetail> createState() => _PersonalDetailState();
}

class _PersonalDetailState extends State<PersonalDetail> {
  final PersonalDetailController personalDetailController =
      Get.put(PersonalDetailController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ProgressContainer(selectedIndex: 1),
      ),
      body: SafeArea(
        child: Container(
            margin: EdgeInsets.only(top: 5),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ColorX.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                )
              ],
            ),
            child: Obx(
              () => _buildCurrentScreen(
                  personalDetailController.currentScreen.value),
            )),
      ),
    );
  }

  Widget _buildCurrentScreen(PersonalDetailScreen screen) {
    switch (screen) {
      case PersonalDetailScreen.name:
        return NameScreen();
      case PersonalDetailScreen.email:
        return EmailVerification();
      case PersonalDetailScreen.pan:
        return PanDetail();
    }
  }
}
