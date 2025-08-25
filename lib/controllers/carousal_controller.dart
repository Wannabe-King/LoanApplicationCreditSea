import 'package:get/get.dart';

class CarouselIndicatorController extends GetxController {
  var currentIndex = 0.obs;

  void next(int index) {
    currentIndex.value = index;
  }
}