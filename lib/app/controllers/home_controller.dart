import 'dart:async';

import 'package:cyptarapoto/app/routes/pages_app.dart';
import 'package:cyptarapoto/app/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/models/collegiate _model.dart';
import '../data/models/event_model.dart';
import '../data/provider/eventprovider.dart';

class HomeController extends GetxController {
  GetStorage box = GetStorage('GlobalStorage');
  var collegiate = Collegiate(
    address: '',
    birthdate: '',
    code: '',
    email: '',
    gender: '',
    id: 0,
    member: '',
    phone: 0,
    status: false,
    docId: '',
  ).obs;

  final events = <Event>[].obs;
  final EventProvider _provider = EventProvider();
  final isLoading = false.obs;
  final hasMore = true.obs;

  StreamSubscription<List<Event>>? eventsSubscription;

  @override
  Future<void> onInit() async {
    await FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    await FlutterStatusbarcolor.setNavigationBarColor(secondaryColor);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    loadCollegiateData();
    fetchEvents();
    print('onInit');

    super.onInit();
  }

  void loadCollegiateData() {
    final storedCollegiate = box.read('collegiate');
    print(storedCollegiate.toString());
    if (storedCollegiate != null) {
      final docId = storedCollegiate['docId'] as String; // Extrae el docId
      collegiate.value = Collegiate.fromMap(
          Map<String, dynamic>.from(storedCollegiate), docId);
    }
  }

  String getFirstName() {
    return collegiate.value.member.split(' ').first;
  }

  void fetchEvents() {
    isLoading.value = true;
    try {
      eventsSubscription = _provider.getEvents().listen((newEvents) {
        if (newEvents.length < 25) {
          hasMore.value = false;
        }
        events.clear(); // Clear the existing list before adding new data
        events.addAll(newEvents);
        isLoading.value = false;
      });
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to fetch events: $e');
    }
  }

  @override
  void onClose() {
    eventsSubscription?.cancel();
    super.onClose();
  }

  void loadMore() {
    if (isLoading.value || !hasMore.value) return;
    isLoading.value = true;
    eventsSubscription
        ?.cancel(); // Cancel the current subscription before fetching more data
    fetchEvents();
  }

  Future<void> openWhatsapp() async {
    const url = "https://wa.me/51942637236";
    var uri = Uri.parse(url); // Convierte la URL a un objeto Uri
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  void navigationToProfile() {
    Get.toNamed(Routes.PROFILE);
  }
}
