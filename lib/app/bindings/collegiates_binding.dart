
import 'package:get/get.dart';
import '../controllers/collegiates_controller.dart';


class CollegiatesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CollegiatesController>(() => CollegiatesController());
  }
}