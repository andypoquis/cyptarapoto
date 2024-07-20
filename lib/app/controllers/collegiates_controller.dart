import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/models/collegiate _model.dart';
import '../data/provider/cypprovider.dart';

class CollegiatesController extends GetxController {
  final collegiates = <Collegiate>[].obs;
  final CYPProvider _provider = CYPProvider();
  final isLoading = false.obs;
  final hasMore = true.obs;

  StreamSubscription<List<Collegiate>>? collegiatesSubscription;

  final addressController = TextEditingController();
  final birthdateController = TextEditingController();
  final codeController = TextEditingController();
  final emailController = TextEditingController();
  final genderController = TextEditingController();
  final idController = TextEditingController();
  final memberController = TextEditingController();
  final phoneController = TextEditingController();
  final statusController = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCollegiates();
  }

  @override
  void onClose() {
    collegiatesSubscription?.cancel();
    super.onClose();
  }

  void fetchCollegiates() {
    collegiatesSubscription =
        _provider.getCollegiates().listen((newCollegiates) {
      if (newCollegiates.length < 25) {
        hasMore.value = false;
      }
      collegiates.clear(); // Clear the existing list before adding new data
      collegiates.addAll(newCollegiates);
      isLoading.value = false;
    });
  }

  void loadMore() {
    if (isLoading.value || !hasMore.value) return;
    isLoading.value = true;
    collegiatesSubscription
        ?.cancel(); // Cancel the current subscription before fetching more data
    fetchCollegiates();
  }

  Future<void> addCollegiate() async {
    Collegiate newCollegiate = Collegiate(
      address: addressController.text,
      birthdate: birthdateController.text,
      code: codeController.text,
      email: emailController.text,
      gender: genderController.text,
      id: int.parse(idController.text),
      member: memberController.text,
      phone: int.parse(phoneController.text),
      status: statusController.value,
    );

    await _provider.addCollegiate(newCollegiate);
    fetchCollegiates(); // Fetch the list again to include the new collegiate
  }
}
