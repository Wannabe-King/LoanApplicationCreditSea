import 'package:carousel_slider/carousel_slider.dart';
import 'package:creditsea_flutter_assignment/config/carousal_items.dart';
import 'package:creditsea_flutter_assignment/config/color.dart';
import 'package:creditsea_flutter_assignment/controllers/auth_controller.dart';
import 'package:creditsea_flutter_assignment/controllers/carousal_controller.dart';
import 'package:creditsea_flutter_assignment/view/screens/signin.dart';
import 'package:creditsea_flutter_assignment/view/screens/signupFlow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final AuthType authenticationType = Get.put(AuthType(), permanent: true);

  final CarouselSliderController _controller = CarouselSliderController();
  final CarouselIndicatorController indicator =
      Get.put(CarouselIndicatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorX.backgroundBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CarouselSlider(
                      carouselController: _controller,
                      options: CarouselOptions(
                        viewportFraction: 1.0,
                        aspectRatio: 16 / 9,
                        height: MediaQuery.of(context).size.height * 0.47,
                        autoPlay: true,
                        onPageChanged: (index, reason) {
                          indicator.next(index);
                        },
                      ),
                      items: CarousalItems.pages,
                    ),
                    _buildIndicator(),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.45,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 26, horizontal: 16),
                decoration: BoxDecoration(
                    color: ColorX.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Obx(() => authenticationType.authType.value == 0
                    ? SignUpFlow()
                    : SignIn()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndicator() {
    return GetX<CarouselIndicatorController>(builder: (controller) {
      return AnimatedSmoothIndicator(
        activeIndex: indicator.currentIndex.value,
        count: 3,
        effect: WormEffect(
          dotHeight: 10,
          dotWidth: 10,
          activeDotColor: Colors.blueAccent,
          dotColor: Colors.grey,
        ),
        onDotClicked: (index) => _controller.animateToPage(index),
      );
    });
  }
}
