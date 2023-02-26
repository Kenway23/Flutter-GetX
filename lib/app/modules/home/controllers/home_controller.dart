import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:examp/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:examp/app/modules/dashboard/views/dashboard_view.dart';
import 'dart:async';
import 'package:examp/app/modules/login/views/login_view.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  late Timer _pindah;
  final authToken = GetStorage();
  // final count = 0.obs;
  @override
  void onInit() {
    _pindah = Timer.periodic(
        const Duration(seconds: 4),
        (timer) => authToken.read('token') == null
            ? Get.off(
                () =>  LoginView(),
                transition: Transition.leftToRight,
              )
            : Get.off(() => const DashboardView()));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    _pindah.cancel();
    super.onClose();
  }

  // void increment() => count.value++;
}