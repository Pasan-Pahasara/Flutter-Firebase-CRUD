import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Get collection of notes
  final CollectionReference notesCollection =
      FirebaseFirestore.instance.collection('notes');
}
