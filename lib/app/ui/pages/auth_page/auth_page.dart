import 'package:cyptarapoto/app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';

class AuthPage extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    final Size sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.centerLeft,
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(30),
            children: [
              Center(child: widgetLogo(sizeScreen)),
              const SizedBox(height: 20),

              const Center(child: Text('Ingresa con tus credenciales')),
              const SizedBox(height: 8),

              const Center(child: Text('CDSM-Tarapoto')),

              const SizedBox(height: 21),
              SizedBox(
                height: 42,
                child: TextField(
                  onSubmitted: (_) => FocusScope.of(context)
                      .requestFocus(controller.emailFocusNode),
                  focusNode: controller.emailFocusNode,
                  controller: controller.usernameController,
                  keyboardType: TextInputType.number,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Color(0xffd9d9d9)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffd9d9d9)),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffd9d9d9)),
                    ),
                    hintText: 'Usuario',
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Obx(
                () => SizedBox(
                  height: 42,
                  child: TextField(
                    controller: controller.passwordController,
                    focusNode: controller.passwordFocusNode,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: controller.obscureText.value,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(color: Color(0xffd9d9d9)),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffd9d9d9)),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffd9d9d9)),
                      ),
                      hintText: 'Contraseña',
                      suffixIcon: IconButton(
                        onPressed: () => controller.obscureText.value =
                            !controller.obscureText.value,
                        icon: !controller.obscureText.value
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined),
                        iconSize: 21,
                        color: const Color(0xffd9d9d9),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  SizedBox(
                    height: 24.0,
                    width: 24.0,
                    child: Checkbox(
                      value: false,
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text('Recordar credenciales'),
                ],
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: sizeScreen.width,
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
                  onPressed: () => controller.authenticate(),
                  child: const Text(
                    'Acceder',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 9),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('¿Olvidó su contraseña?'),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Recupérala aquí'),
                  ),
                ],
              ),
              const SizedBox(height: 40), // Espacio en blanco
              const Center(
                child: Text(
                  '© Copyright - CDSM-Tarapoto 2024',
                  style: TextStyle(fontSize: 10, color: Colors.black45),
                ),
              ),
              const Center(
                child: Text(
                  'cipNotify v1.0.0',
                  style: TextStyle(fontSize: 10, color: Colors.black45),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetLogo(Size sizeScreen) {
    return Image.asset(
      'assets/images/logo.png',
      width: sizeScreen.width * 0.57,
    );
  }
}
