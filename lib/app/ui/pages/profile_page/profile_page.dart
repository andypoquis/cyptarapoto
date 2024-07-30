import 'package:cyptarapoto/app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    final sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('ProfilePage'),
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Container()),
          Center(
            child: SizedBox(
              width: sizeScreen.width * 0.65,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(secondaryColor),
                ),
                onPressed: () => controller.logout(),
                child: const Text(
                  'Cerrar Sesion',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      )),
    );
  }
}
