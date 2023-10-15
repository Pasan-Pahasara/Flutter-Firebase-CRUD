import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();

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
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
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
    );
  }
}
