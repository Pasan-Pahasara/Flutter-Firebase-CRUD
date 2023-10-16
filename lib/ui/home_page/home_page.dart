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
  void openNotePopUp() {
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
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          // Add button
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Add note to Firestore
              _firestore.addNote(
                _nameController.text,
              );

              // Clear the text controller
              _nameController.clear();
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
    );
  }
}
