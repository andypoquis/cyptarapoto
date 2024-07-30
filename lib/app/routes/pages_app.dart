import 'package:cyptarapoto/app/bindings/auth_binding.dart';
import 'package:cyptarapoto/app/bindings/bottomnavbar_binding.dart';
import 'package:cyptarapoto/app/bindings/collegiates_binding.dart';
import 'package:cyptarapoto/app/bindings/events_binding.dart';
import 'package:cyptarapoto/app/bindings/home_binding.dart';
import 'package:cyptarapoto/app/bindings/profile_binding.dart';
import 'package:cyptarapoto/app/ui/pages/auth_page/auth_page.dart';
import 'package:cyptarapoto/app/ui/pages/bottomnavbar_page/bottomnavbar_page.dart';
import 'package:cyptarapoto/app/ui/pages/collegiates_page/newcollegiates_page.dart';
import 'package:cyptarapoto/app/ui/pages/events_page/newevent_page.dart';
import 'package:cyptarapoto/app/ui/pages/home_page/home_page.dart';
import 'package:cyptarapoto/app/ui/pages/profile_page/profile_page.dart';
import 'package:get/get.dart';

part './routes_app.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: Routes.HOME, page: () => HomePage(), binding: HomeBinding()),
    GetPage(name: Routes.AUTH, page: () => AuthPage(), binding: AuthBinding()),
    GetPage(
        name: Routes.SIDEBAR,
        page: () => BottomnavbarPage(),
        binding: BottomnavbarBinding()),
    GetPage(
        name: Routes.NEWCOLLEGIATES,
        page: () => NewCollegiatesPage(),
        binding: CollegiatesBinding()),
    GetPage(
        name: Routes.NEWEVENTPAGE,
        page: () => NewEventPage(),
        binding: EventsBinding()),
    GetPage(
        name: Routes.PROFILE,
        page: () => ProfilePage(),
        binding: ProfileBinding())
  ];
}
