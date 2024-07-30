import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyptarapoto/app/shared/getx.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  final imageName = ''.obs;
  final imageFile = Rx<File?>(null);

  StreamSubscription<List<Event>>? eventsSubscription;

  final TextEditingController dispatchCalendarSelectorCnt =
      TextEditingController();

  final attendeesController = TextEditingController();
  final descriptionController = TextEditingController();
  final endDateController = TextEditingController();
  final imageController = TextEditingController();
  final locationController = TextEditingController();
  final startDateController = TextEditingController();
  final titleController = TextEditingController();
  final organizeController = TextEditingController();

  final QuillEditorController htmlInputController = QuillEditorController();

  Rx<String?> partialDispatchDate = RxNullable<String?>().setNull();

  String? currentDocId;

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  Future<void> loadEventData(Event event, String docId) async {
    //attendeesController.text = event.attendees;
    await htmlInputController.setText(event.description);
    endDateController.text = event.endDate;
    imageController.text = event.image;
    locationController.text = event.location;
    titleController.text = event.title;

    currentDocId = docId;
  }

  void clearControllers() {
    htmlInputController.clear();
    endDateController.clear();
    locationController.clear();
    titleController.clear();
  }

  void onChangeDispatchDate(String? date) {
    partialDispatchDate.value = date;
  }

  Future<void> editEvent() async {
    if (currentDocId == null) return;

    Event updateEvent = Event(
      id: '',
      attendees: [],
      description: await htmlInputController.getText(),
      endDate: dispatchCalendarSelectorCnt.text,
      image: imageController.text,
      location: locationController.text,
      title: titleController.text,
    );
    await _provider.updateEvent(currentDocId!, updateEvent);
  }

  Future<void> deleteEvent() async {
    _provider.deleteEvent(currentDocId ?? '');
    Get.back();
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
      // Primero, agrega el evento a Firestore sin la URL de la imagen
      DocumentReference docRef = await _provider.addEvent(Event(
        id: '',
        attendees: [],
        description: await htmlInputController.getText(),
        endDate: dispatchCalendarSelectorCnt.text,
        image: '',
        location: locationController.text,
        title: titleController.text,
      ));

      // Luego, sube la imagen a Firebase Storage
      if (imageFile.value != null) {
        final storageRef = FirebaseStorage.instance.ref();
        final imageRef = storageRef.child('events/${docRef.id}/portada.jpg');

        final uploadTask = imageRef.putFile(
          imageFile.value!,
          SettableMetadata(contentType: 'image/jpeg'),
        );

        final snapshot = await uploadTask;
        final downloadUrl = await snapshot.ref.getDownloadURL();

        // Actualiza el documento con la URL de la imagen
        await docRef.update({'image': downloadUrl});
      }

      //fetchEvents(); // Fetch the list again to include the new event
    } catch (e) {
      Get.snackbar('Error', 'Failed to add event: $e');
    }
  }

  @override
  void onClose() {
    eventsSubscription?.cancel();
    super.onClose();
  }
}
