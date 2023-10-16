import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_crud/services/firestore/firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Firestore service
  final FirestoreService _firestore = FirestoreService();

  // Text controller for the name field
  final TextEditingController _nameController = TextEditingController();

  // Open the note pop up
  void openNotePopUp({String? docID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Note'),
        content: TextField(
          controller: _nameController,
          decoration: const InputDecoration(hintText: "Enter note here"),
        ),
        actions: [
          // Cancel button
          ElevatedButton(
            onPressed: () {
              // Close the pop up
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          // Add button
          ElevatedButton(
            onPressed: () {
              // Add note to Firestore
              if (docID == null) {
                _firestore.addNote(_nameController.text);
              }
              // Update note in Firestore
              else {
                _firestore.updateNote(
                  _nameController.text,
                  docID,
                );
              }
              // Clear the text controller
              _nameController.clear();
              // Close the pop up
              Navigator.of(context).pop();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 7,
        centerTitle: true,
        title: const Text('Ո ૦ ੮ ૯ Տ',
            style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFA87E5A),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        actions: [
          IconButton(
            onPressed: () {},
            icon:
                const Icon(Icons.share_outlined, color: Colors.white, size: 30),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openNotePopUp,
        backgroundColor: const Color(0xFFA87E5A),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _firestore.getNotes(),
          builder: (context, snapshot) {
            // If we have data, get all the docs
            if (snapshot.hasData) {
              List notesList = snapshot.data!.docs;

              // If we have data, show a list of notes
              return ListView.builder(
                itemCount: notesList.length,
                itemBuilder: (context, index) {
                  // Get each induvidual doc
                  DocumentSnapshot document = notesList[index];
                  String docID = document.id;

                  // Get note from each doc
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  if (data.containsKey('notes') && data['notes'] != null) {
                    String noteText = data['notes'];
                    // Return a widget showing the note
                    return ListTile(
                      title: Text(noteText),
                      trailing: IconButton(
                        onPressed: () => openNotePopUp(docID: docID),
                        icon: const Icon(Icons.settings_outlined),
                      ),
                    );
                  }
                },
              );
            } else {
              // If we don't have data, show a loading spinner
              return const Center(
                // child: CircularProgressIndicator(),
                child: Text('No notes yet!'),
              );
            }
          }),
    );
  }
}
