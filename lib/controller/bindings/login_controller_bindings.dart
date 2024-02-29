import 'package:get/get.dart';
import 'package:pill_cart/controller/login_controller.dart';

class LoginControllerBindings implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}