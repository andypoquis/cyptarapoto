import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/event_model.dart';

class EventProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentSnapshot? lastDocument;

  Stream<List<Event>> getEvents({int limit = 25}) {
    Query query =
        _firestore.collection('events').orderBy('endDate').limit(limit);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument!);
    }

    return query.snapshots().map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        lastDocument = snapshot.docs.last;
      }
      return snapshot.docs.map((doc) {
        return Event.fromMap(doc.data() as Map<String, dynamic>,
            doc.id); // Pasar el ID del documento
      }).toList();
    });
  }

  Future<void> addEvent(Event event) async {
    try {
      await _firestore.collection('events').add(event.toMap());
    } catch (e) {
      print('Error adding event: $e');
      rethrow;
    }
  }
}
