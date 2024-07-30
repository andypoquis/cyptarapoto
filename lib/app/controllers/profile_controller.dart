import 'package:cyptarapoto/app/routes/pages_app.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  void logout() {
    GetStorage box = GetStorage();
    box.write("isloged", false);
    box.erase();
    Get.toNamed(Routes.AUTH);
  }
}
