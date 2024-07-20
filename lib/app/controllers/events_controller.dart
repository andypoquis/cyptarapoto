import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quill_html_editor/quill_html_editor.dart';

import '../data/models/event_model.dart';
import '../data/provider/eventprovider.dart';

class EventsController extends GetxController {
  final events = <Event>[].obs;
  final EventProvider _provider = EventProvider();
  final isLoading = false.obs;
  final hasMore = true.obs;

  StreamSubscription<List<Event>>? eventsSubscription;

  final attendeesController = TextEditingController();
  final descriptionController = TextEditingController();
  final endDateController = TextEditingController();
  final imageController = TextEditingController();
  final locationController = TextEditingController();
  final startDateController = TextEditingController();
  final titleController = TextEditingController();
  final organizeController = TextEditingController();

  final QuillEditorController htmlInputController = QuillEditorController();

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  @override
  void onClose() {
    eventsSubscription?.cancel();
    super.onClose();
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

  void loadMore() {
    if (isLoading.value || !hasMore.value) return;
    isLoading.value = true;
    eventsSubscription
        ?.cancel(); // Cancel the current subscription before fetching more data
    fetchEvents();
  }

  Future<void> addEvent() async {
    try {
      Event newEvent = Event(
        id: '',
        attendees: [],
        description: await htmlInputController.getText(),
        endDate: endDateController.text,
        image: imageController.text,
        location: locationController.text,
        title: titleController.text,
      );

      await _provider.addEvent(newEvent);
      fetchEvents(); // Fetch the list again to include the new event
    } catch (e) {
      Get.snackbar('Error', 'Failed to add event: $e');
    }
  }
}
