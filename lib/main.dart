import 'package:cyptarapoto/app/bindings/auth_binding.dart';
import 'package:cyptarapoto/app/bindings/home_binding.dart';
import 'package:cyptarapoto/app/routes/pages_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init('GlobalStorage');
  GetStorage box = GetStorage('GlobalStorage');

  bool isloged = box.read("isloged") ?? false;
  print('isloged: $isloged');

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    // ignore: unnecessary_null_comparison
    initialRoute: !isloged ? Routes.AUTH : Routes.HOME,
    theme: ThemeData(
      iconTheme: IconThemeData(color: Colors.white),
      primaryColor: const Color(0xffE84E4E), // Color principal
      focusColor: const Color(0xffE84E4E),
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: Color.fromARGB(101, 83, 128, 251),
        selectionHandleColor: Color(0xff5381FB),
        cursorColor: Color(0xffE84E4E),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white, // Color de fondo del AppBar
        elevation: 0, // Sin sombra
        systemOverlayStyle:
            SystemUiOverlayStyle.dark, // Iconos del sistema en oscuro
      ),
      inputDecorationTheme: const InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff5381FB), width: 2.0),
        ),
      ),
      cardColor: Colors.white,
      cardTheme: CardTheme(color: Colors.white),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(
              const Color(0xffE84E4E)), // Color del texto en los TextButton
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xff5381FB)),
        ),
      ),
    ),
    initialBinding: !isloged ? AuthBinding() : HomeBinding(),
    defaultTransition: Transition.fade,
    getPages: AppPages.pages,
  ));
}
