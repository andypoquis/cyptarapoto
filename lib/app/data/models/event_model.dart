import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String id;
  final List<String> attendees;
  final String description;
  final String endDate; // keep as String
  final String image;
  final String location;
  final String title;

  Event({
    required this.id,
    required this.attendees,
    required this.description,
    required this.endDate,
    required this.image,
    required this.location,
    required this.title,
  });

  factory Event.fromMap(Map<String, dynamic> data, String documentId) {
    // Convert the 'endDate' field to String if it is a Timestamp
    String endDateString;
    if (data['endDate'] is Timestamp) {
      endDateString = (data['endDate'] as Timestamp).toDate().toString();
    } else {
      endDateString = data['endDate'] as String;
    }

    return Event(
      id: documentId,
      attendees:
          data['attendees'] != null ? List<String>.from(data['attendees']) : [],
      description: data['description'] ?? '',
      endDate: endDateString,
      image: data['image'] ?? '',
      location: data['location'] ?? '',
      title: data['title'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    // Convert the 'endDate' field to Timestamp if it is a valid date string
    Timestamp endDateTimestamp;
    try {
      endDateTimestamp = Timestamp.fromDate(DateTime.parse(endDate));
    } catch (e) {
      endDateTimestamp = Timestamp.now();
    }

    return {
      'attendees': attendees,
      'description': description,
      'endDate': endDateTimestamp,
      'image': image,
      'location': location,
      'title': title,
    };
  }
}
