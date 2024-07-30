import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cyptarapoto/app/data/models/collegiate%20_model.dart';

class CYPProvider {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DocumentSnapshot? lastDocument;
  bool hasMore = true;

  Stream<List<Collegiate>> getCollegiates({int limit = 25}) {
    Query query =
        _firestore.collection('collegiates').orderBy('ID').limit(limit);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument!);
    }

    return query.snapshots().map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        lastDocument = snapshot.docs.last;
      }
      if (snapshot.docs.length < limit) {
        hasMore = false;
      }
      return snapshot.docs.map((doc) {
        return Collegiate.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  Future<void> addCollegiate(Collegiate collegiate) async {
    await _firestore.collection('collegiates').add(collegiate.toMap());
  }

  Future<void> updateCollegiate(String docId, Collegiate collegiate) async {
    await _firestore
        .collection('collegiates')
        .doc(docId)
        .update(collegiate.toMap());
  }
}
