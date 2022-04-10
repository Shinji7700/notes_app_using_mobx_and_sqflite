// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notes_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NotesStore on _NotesStore, Store {
  final _$loadingAtom = Atom(name: '_NotesStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$notesListAtom = Atom(name: '_NotesStore.notesList');

  @override
  ObservableList<NotesModel> get notesList {
    _$notesListAtom.reportRead();
    return super.notesList;
  }

  @override
  set notesList(ObservableList<NotesModel> value) {
    _$notesListAtom.reportWrite(value, super.notesList, () {
      super.notesList = value;
    });
  }

  final _$addNotesAsyncAction = AsyncAction('_NotesStore.addNotes');

  @override
  Future<void> addNotes() {
    return _$addNotesAsyncAction.run(() => super.addNotes());
  }

  final _$showNotesAsyncAction = AsyncAction('_NotesStore.showNotes');

  @override
  Future<void> showNotes() {
    return _$showNotesAsyncAction.run(() => super.showNotes());
  }

  final _$updateNotesAsyncAction = AsyncAction('_NotesStore.updateNotes');

  @override
  Future<void> updateNotes() {
    return _$updateNotesAsyncAction.run(() => super.updateNotes());
  }

  final _$deleteNotesAsyncAction = AsyncAction('_NotesStore.deleteNotes');

  @override
  Future<void> deleteNotes(int id) {
    return _$deleteNotesAsyncAction.run(() => super.deleteNotes(id));
  }

  final _$_NotesStoreActionController = ActionController(name: '_NotesStore');

  @override
  void closeDb() {
    final _$actionInfo =
        _$_NotesStoreActionController.startAction(name: '_NotesStore.closeDb');
    try {
      return super.closeDb();
    } finally {
      _$_NotesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
notesList: ${notesList}
    ''';
  }
}
