import 'package:cyptarapoto/app/routes/pages_app.dart';
import 'package:cyptarapoto/app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';

class BottomnavbarController extends GetxController {
  RxInt indexMenu = 0.obs;

  RxList<IconData> iconDataMenu = [
    FontAwesome.person_chalkboard_solid,
    FontAwesome.calendar_days,
  ].obs;

  RxList<String> tabTitles = [
    "Colegiados",
    "Eventos",
  ].obs;

  RxString avatarUrl = ''.obs;

  @override
  Future<void> onInit() async {
    await FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    await FlutterStatusbarcolor.setNavigationBarColor(secondaryColor);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    super.onInit();
  }

  navigationProfilePage() {
    Get.toNamed(Routes.PROFILE);
  }
}
