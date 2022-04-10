import 'package:flutter/material.dart';
import 'package:notes_app_using_sqflite/notes_app/store/notes_store.dart';
import 'package:provider/provider.dart';

class EditNotes extends StatelessWidget {
  const EditNotes({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final notesStore = context.read<NotesStore>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Notes'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            initialValue:
                notesStore.notesList[notesStore.selectedNoteIndex].title,
            onChanged: (val) {
              notesStore.updatedTitle = val;
            },
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            initialValue:
                notesStore.notesList[notesStore.selectedNoteIndex].description,
            onChanged: (val) {
              notesStore.updatedDesc = val;
            },
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
                await notesStore.updateNotes();
                Navigator.pop(context);
              },
              child: const Text("Update Data"))
        ],
      ),
    );
  }
}
