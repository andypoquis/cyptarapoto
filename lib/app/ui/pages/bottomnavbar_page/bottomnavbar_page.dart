import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cyptarapoto/app/routes/pages_app.dart';
import 'package:cyptarapoto/app/shared/constants.dart';
import 'package:cyptarapoto/app/ui/pages/collegiates_page/collegiates_page.dart';
import 'package:cyptarapoto/app/ui/pages/events_page/events_page.dart';
import 'package:cyptarapoto/app/ui/pages/home_page/home_page.dart';
import 'package:cyptarapoto/app/widgets/custom_app_bar_widget.dart';
import 'package:cyptarapoto/app/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/bottomnavbar_controller.dart';

class BottomnavbarPage extends GetView<BottomnavbarController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
            searchWidget: SearchWidget(),
            trailing: Obx(() {
              if (controller.avatarUrl.value.isEmpty) {
                return CircleAvatar(
                  child: Text(
                    'A',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.lightGreen,
                );
              } else {
                return CircleAvatar(
                  child: Text(
                    'A',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
            })),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).primaryColor,
          isExtended: true,
          onPressed: () => controller.indexMenu.value == 0
              ? Get.toNamed(Routes.NEWCOLLEGIATES)
              : Get.toNamed(Routes.NEWEVENTPAGE),
          label: Row(
            children: [
              const Icon(
                Icons.add,
                color: Colors.white,
              ),
              const SizedBox(
                width: 5,
              ),
              Obx(() => controller.indexMenu.value == 0
                  ? Text(
                      'Nuevo ${controller.tabTitles[controller.indexMenu.value].substring(0, controller.tabTitles[controller.indexMenu.value].length - 1)}',
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      'Nuevo ${controller.tabTitles[controller.indexMenu.value].substring(0, controller.tabTitles[controller.indexMenu.value].length - 1)}',
                      style: TextStyle(color: Colors.white),
                    )),
            ],
          ),
        ),
        body: Obx(() => AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              child: bodyItemWidget(controller.indexMenu.value),
            )),
        bottomNavigationBar: Obx(
          () => AnimatedBottomNavigationBar.builder(
            backgroundColor: const Color(0xff001529),
            itemCount: controller.iconDataMenu.length,
            tabBuilder: (index, isActive) {
              final color =
                  isActive ? Theme.of(context).primaryColor : Colors.white;
              final textStyle = isActive
                  ? TextStyle(color: color, fontWeight: FontWeight.bold)
                  : TextStyle(color: color);
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    controller.iconDataMenu[index],
                    color: color,
                    size: 24,
                  ),
                  SizedBox(height: 4),
                  Text(
                    controller.tabTitles[index],
                    style: textStyle,
                  )
                ],
              );
            },
            leftCornerRadius: 24,
            rightCornerRadius: 24,
            gapLocation: GapLocation.center,
            activeIndex: controller.indexMenu.value,
            notchSmoothness: NotchSmoothness.verySmoothEdge,
            onTap: (index) {
              controller.indexMenu.value = index;
            },
          ),
        ),
      ),
    );
  }

  Widget bodyItemWidget(int index) {
    switch (index) {
      case 0:
        return CollegiatesPage();
      case 1:
        return EventsPage();
      default:
        return Container();
    }
  }
}
