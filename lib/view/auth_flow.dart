// import 'package:_app/constants/constants.dart';
// import 'package:_app/controllers/authentication_flow_carousel_controller.dart';
// import 'package:_app/routes/authentication_type.dart';
// import 'package:_app/view/signin_flow.dart';
// import 'package:_app/view/signup_flow.dart';
// import 'package:_app/view/widgets/carouselSliderItem.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';

// class AuthenticationFlow extends StatefulWidget {
//   AuthenticationFlow({super.key});

//   @override
//   State<AuthenticationFlow> createState() => _AuthenticationFlowState();
// }

// class _AuthenticationFlowState extends State<AuthenticationFlow> {
//   final CarouselControllerX carouselControllerX =
//       Get.put(CarouselControllerX());

//   final AuthenticationType authenticationType = Get.put(AuthenticationType());

//   final List<CarouselSlideritem> _list = carouselList.map((item) {
//     return CarouselSlideritem(
//       svg: item.svgFrame,
//       title: item.title,
//       subtitle: item.subtitle,
//     );
//   }).toList();

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent, // Transparent status bar
//         statusBarIconBrightness: Brightness.light, // White status bar icons
//         statusBarBrightness: Brightness.dark, // For iOS
//       ),
//     );
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: AppColors.backgroundColor,
//       body: Center(
//         child: Column(
//           children: [
//             Spacer(
//               flex: 6,
//             ),
//             Expanded(
//                 flex: 8,
//                 child: SvgPicture.asset(svgAssets.logo_nd_name_horizontal)),
//             Spacer(
//               flex: 2,
//             ),
//             Expanded(
//                 flex: 23,
//                 child: CarouselSlider(
//                     items: _list,
//                     options: CarouselOptions(
//                       height: 300,
//                       initialPage: 0,
//                       viewportFraction: 1,
//                       onPageChanged: (index, reason) {
//                         carouselControllerX.updateIndex(index);
//                       },
//                     ))),
//             Expanded(
//                 flex: 3,
//                 child: Obx(
//                   () {
//                     return _buildIndicator(
//                         carouselControllerX.currentIndex.value);
//                   },
//                 )),
//             Spacer(
//               flex: 1,
//             ),
//             Expanded(
//                 flex: 40,
//                 child: Stack(children: [
//                   Positioned(
//                     left: 0,
//                     right: 0,
//                     bottom: 0, // Aligned to bottom
//                     height: 428,
//                     child: Container(
//                       decoration: const BoxDecoration(
//                           color: Colors.red,
//                           gradient: LinearGradient(colors: [
//                             AppColors.gradientColorBlue,
//                             AppColors.gradientColorGreen
//                           ]),
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(25),
//                               topRight: Radius.circular(25))),
//                     ),
//                   ),
//                   Positioned(
//                     left: 0,
//                     right: 0,
//                     bottom: 0, // Aligned to bottom
//                     height: 418,
//                     child: Container(
//                       decoration: const BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(20),
//                               topRight: Radius.circular(20))),
//                       child: Obx(() =>
//                           authenticationType.authenticationType == 0
//                               ? SignUpFlow()
//                               : SignInFlow()),
//                     ),
//                   ),
//                 ]))
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildIndicator(int index) {
//     return Center(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Spacer(),
//           index == 0 ? _getActiveDot() : _getInactiveDot(),
//           SizedBox(
//             width: 10,
//           ),
//           index == 1 ? _getActiveDot() : _getInactiveDot(),
//           SizedBox(
//             width: 10,
//           ),
//           index == 2 ? _getActiveDot() : _getInactiveDot(),
//           Spacer()
//         ],
//       ),
//     );
//   }

//   Widget _getActiveDot() {
//     return SvgPicture.asset(svgAssets.activeSliderButton);
//   }

//   Widget _getInactiveDot() {
//     return SvgPicture.asset(svgAssets.inactiveSliderButton);
//   }
// }