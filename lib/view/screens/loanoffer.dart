import 'package:creditsea_flutter_assignment/config/assets.dart';
import 'package:creditsea_flutter_assignment/config/color.dart';
import 'package:creditsea_flutter_assignment/controllers/loan_controller.dart';
import 'package:creditsea_flutter_assignment/view/screens/applicationstatus.dart';
import 'package:creditsea_flutter_assignment/view/widget/custombutton.dart';
import 'package:creditsea_flutter_assignment/view/widget/progress_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanOffer extends StatefulWidget {
  const LoanOffer({super.key});

  @override
  State<LoanOffer> createState() => _LoanOfferState();
}

class _LoanOfferState extends State<LoanOffer> {
  final LoanController loanController = Get.find<LoanController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ProgressContainer(
          selectedIndex: 2,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 16),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    "Our Offerings",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 80),
                    child: Image.asset(
                      Assets.dollar,
                      scale: 5,
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(fontSize: 16, color: Colors.black), //
                        children: [
                          TextSpan(
                            text: "Congratulations!",
                            style: TextStyle(color: ColorX.green),
                          ),
                          TextSpan(text: " We can offer you "),
                          TextSpan(
                            text: "Rs. 10,000",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: " Amount Within "),
                          TextSpan(
                            text: "30 minutes",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: " for "),
                          TextSpan(
                            text: "90 days",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: ", with a payable amount of "),
                          TextSpan(
                            text: "Rs. 10,600",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: ". Just with few more steps.\n\n "),
                          TextSpan(
                            text: "Proceed further to",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            CustomButton(
              buttonText: "Accept Offer",
              disabled: true,
              onTap: () {
                createLoan();
              },
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
              buttonText: "Extend Offer",
              disabled: true,
              background: ColorX.white,
            ),
          ],
        ),
      ),
    );
  }

  void createLoan() async {
    await loanController.registerLoan(context);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ApplicationStatus()));
  }
}
