import 'package:get/get.dart';
import 'package:pill_cart/controller/register_user_controller.dart';

class RegisterUserControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<RegisterUserController>(RegisterUserController(), permanent: true);
  }
}
