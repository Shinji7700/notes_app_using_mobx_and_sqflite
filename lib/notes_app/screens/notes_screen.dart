import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:notes_app_using_sqflite/notes_app/widgets/add_notes.dart';
import 'package:notes_app_using_sqflite/notes_app/widgets/edit_notes.dart';
import 'package:provider/provider.dart';

import '../store/notes_store.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  late final NotesStore notesStore = context.read<NotesStore>();

  @override
  void initState() {
    notesStore.showNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var formattedDate = DateFormat('dd-MM-yyyy');
    var formattedTime = DateFormat('kk:mm:a');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        centerTitle: true,
      ),
      body: Observer(
        builder: ((context) {
          if (notesStore.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (notesStore.notesList.isEmpty) {
            return const Center(
              child: Text('Data is Empty'),
            );
          } else {
            return ListView.builder(
                itemCount: notesStore.notesList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text(notesStore.notesList[index].id.toString()),
                    title: Text(notesStore.notesList[index].title),
                    subtitle: Text(notesStore.notesList[index].description),
                    trailing: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Column(
                        children: [
                          Wrap(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    notesStore.selectedNoteIndex = index;
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => Provider.value(
                                              value: notesStore,
                                              child: const EditNotes())),
                                    );
                                  },
                                  child: const Icon(Icons.edit)),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await notesStore.deleteNotes(
                                      notesStore.notesList[index].id!);
                                },
                                child: const Icon(
                                  Icons.delete,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                              "${formattedDate.format(notesStore.notesList[index].createdAt)} at ${formattedTime.format(notesStore.notesList[index].createdAt)}"),
                        ],
                      ),
                    ),
                  );
                });
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) =>
                    Provider.value(value: notesStore, child: const AddNotes())),
          );
        },
      ),
    );
  }
}
