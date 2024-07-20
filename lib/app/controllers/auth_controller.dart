import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyptarapoto/app/routes/pages_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../data/models/collegiate _model.dart';

class AuthController extends GetxController {
  GetStorage box = GetStorage();

  RxBool obscureText = true.obs;
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  late final TextEditingController usernameController;
  late final TextEditingController passwordController;

  @override
  void onInit() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  Future<void> authenticate() async {
    final id = int.tryParse(usernameController.text);
    print("id: $id");
    final code = passwordController.text;
    print("code: $code");

    if (id == null || code.isEmpty) {
      Get.snackbar('Error', 'Por favor, ingrese su ID y código.');
      return;
    }

    try {
      if (code == '233558') {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('collegiates')
            .where('ID', isEqualTo: id)
            .where('Code', isEqualTo: code)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          final docData = querySnapshot.docs.first.data();
          final collegiate = Collegiate.fromMap(docData);
          box.write('collegiate', collegiate.toMap());
          Get.offAllNamed(Routes.SIDEBAR);
        } else {
          Get.snackbar('Error', 'Credenciales incorrectas.');
        }
      } else {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('collegiates')
            .where('ID', isEqualTo: id)
            .where('Code', isEqualTo: code)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          final docData = querySnapshot.docs.first.data();
          final collegiate = Collegiate.fromMap(docData);
          box.write('collegiate', collegiate.toMap());
          navigationToSideBarPage();
        } else {
          Get.snackbar('Error', 'Credenciales incorrectas.');
        }
      }
    } catch (e) {
      Get.snackbar(
          'Error', 'Hubo un problema al autenticar. Intente nuevamente.');
    }
  }

  void navigationToSideBarPage() {
    Get.offAllNamed(Routes.HOME);
  }
}
