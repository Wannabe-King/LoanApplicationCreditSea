import 'package:get/get.dart';

class AuthType extends GetxController {
  var authType = 0.obs;

  void alterAuthenticationType() {
    if (authType.value == 0) {
      authType.value = 1;
    } else {
      authType.value = 0;
    }
  }
}
