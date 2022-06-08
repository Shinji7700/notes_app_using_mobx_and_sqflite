import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              key: const Key("Title Key"),
              controller: notesStore.titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Please enter title",
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              key: const Key("Description Key"),
              controller: notesStore.descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Please enter description",
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
                if (notesStore.titleController.text.trim().isNotEmpty &&
                    notesStore.descriptionController.text.trim().isNotEmpty) {
                  await notesStore.addNotes();
                  Navigator.pop(context);
                } else {
                  Fluttertoast.showToast(
                      msg: 'Please add the details',
                      backgroundColor: Colors.black,
                      textColor: Colors.white);
                }
              },
              child: const Text("Add Data"))
        ],
      ),
    );
  }
}
