
import 'package:get/get.dart';
import '../controllers/viewevent_controller.dart';


class VieweventBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VieweventController>(() => VieweventController());
  }
}