import 'package:creditsea_flutter_assignment/config/color.dart';
import 'package:creditsea_flutter_assignment/view/widget/custombutton.dart';
import 'package:creditsea_flutter_assignment/view/widget/progress_container.dart';
import 'package:creditsea_flutter_assignment/view/widget/status_tile.dart';
import 'package:flutter/material.dart';

class ApplicationStatus extends StatefulWidget {
  const ApplicationStatus({super.key});

  @override
  State<ApplicationStatus> createState() => _ApplicationStatusState();
}

class _ApplicationStatusState extends State<ApplicationStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ProgressContainer(
          selectedIndex: 3,
        ),
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
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.arrow_back),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Application Status",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Row(
                children: [
                  RichText(
                      text: TextSpan(
                          style: TextStyle(fontSize: 15, color: Colors.black),
                          children: [
                        TextSpan(
                          text: "Loan application no.",
                          style: TextStyle(fontSize: 15),
                        ),
                        TextSpan(
                          text: "#CS12323",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ])),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              StatusTile(
                status: "Application Submitted",
                done: true,
              ),
              SizedBox(
                height: 20,
              ),
              StatusTile(
                status: "Application under Review",
                done: false,
                color: ColorX.buttonBlue,
              ),
              SizedBox(
                height: 20,
              ),
              StatusTile(
                status: "E-KYC",
                done: false,
              ),
              SizedBox(
                height: 20,
              ),
              StatusTile(
                status: "E-Nach",
                done: false,
              ),
              SizedBox(
                height: 20,
              ),
              StatusTile(
                status: "E-Sign",
                done: false,
              ),
              SizedBox(
                height: 20,
              ),
              StatusTile(
                status: "Disbursement",
                done: false,
              ),
              Spacer(),
              CustomButton(buttonText: "Continue", disabled: true)
            ],
          ),
        ),
      ),
    );
  }
}
