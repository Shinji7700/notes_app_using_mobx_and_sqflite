import 'package:flutter/material.dart';
import 'package:notes_app_using_sqflite/notes_app/store/notes_store.dart';
import 'package:provider/provider.dart';

class AddNotes extends StatelessWidget {
  const AddNotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notesStore = context.read<NotesStore>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Notes'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: notesStore.titleController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Please enter title",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: notesStore.descriptionController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Please enter description",
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
                await notesStore.addNotes();
                Navigator.pop(context);
              },
              child: const Text("Add Data"))
        ],
      ),
    );
  }
}
