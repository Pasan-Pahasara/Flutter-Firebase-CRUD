import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Get collection of notes
  final CollectionReference notesCollection =
      FirebaseFirestore.instance.collection('notes');

  // CREATE: Add a new note
  Future<void> addNote(String note) {
    return notesCollection.add({
      'notes': note,
      'timestamp': Timestamp.now(),
    });
  }

  // READ: Get all notes from Firestore
  Stream<QuerySnapshot> getNotes() {
    final noteStream =
        notesCollection.orderBy('timestamp', descending: true).snapshots();

    return noteStream;
  }
}
