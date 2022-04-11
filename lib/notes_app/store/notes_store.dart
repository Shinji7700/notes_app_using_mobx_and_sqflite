import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:notes_app_using_sqflite/notes_app/model/notes_model.dart';
import 'package:notes_app_using_sqflite/notes_app/repository/notes_sql_db_repository.dart';

part 'notes_store.g.dart';

class NotesStore = _NotesStore with _$NotesStore;
final notesSqlDbRepository = NotesSqlDbRepository.instance;

abstract class _NotesStore with Store {
  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  ///To get the note index to show it in edit page
  int selectedNoteIndex = 0;

  ///To get the updated title for the note
  String updatedTitle = '';

  ///To get the updated desc for the note
  String updatedDesc = '';

  ///To show the loading screen when the data is added from sql database
  @observable
  bool loading = false;

  ///To add the sql data into this list
  @observable
  ObservableList<NotesModel> notesList = ObservableList.of([]);

  ///To add notes
  @action
  Future<void> addNotes() async {
    final notesModel = NotesModel(
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      createdAt: DateTime.now(),
    );

    await notesSqlDbRepository.createNotes(notesModel);
    titleController.clear();
    descriptionController.clear();
    showNotes();
  }

  ///To read notes
  @action
  Future<void> showNotes() async {
    notesList.clear();
    loading = true;
    final value = await notesSqlDbRepository.readAllNotes();
    notesList.addAll(value);
    loading = false;
  }

  ///To update notes
  @action
  Future<void> updateNotes() async {
    final notes = notesList[selectedNoteIndex];

    final notesModel = notes.copyWith(
      title: updatedTitle == '' ? notes.title : updatedTitle,
      description: updatedDesc == '' ? notes.description : updatedDesc,
    );
    await notesSqlDbRepository.updateNotes(notesModel);
    showNotes();
  }

  ///To delete notes
  @action
  Future<void> deleteNotes(int id) async {
    await notesSqlDbRepository.deleteNotes(id);
    notesList.removeWhere((element) => element.id == id);
  }

  ///To close db when we call dispose method
  @action
  void closeDb() {
    notesSqlDbRepository.closeDb();
  }
}
