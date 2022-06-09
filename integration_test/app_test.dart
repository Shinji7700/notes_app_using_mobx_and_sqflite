import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:notes_app_using_sqflite/main.dart';
import 'package:notes_app_using_sqflite/notes_app/screens/notes_screen.dart';
import 'package:notes_app_using_sqflite/notes_app/store/notes_store.dart';
import 'package:notes_app_using_sqflite/notes_app/widgets/add_notes.dart';
import 'package:provider/provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Checking if anything is added in text field while adding notes",
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));

    await tester.pumpAndSettle();

    await tester.tap(find.byType(ElevatedButton));

    await tester.pumpAndSettle();

    expect(find.byType(AddNotes), findsOneWidget);

    await tester.enterText(find.byKey(const ValueKey('Title Key')), 'New Book');

    await tester.tap(find.byType(ElevatedButton));

    await tester.pumpAndSettle();

    expect(find.byType(AddNotes), findsOneWidget);

    await tester.enterText(find.byKey(const ValueKey('Title Key')), '');

    await tester.enterText(
        find.byKey(const ValueKey('Description Key')), 'Elon');

    await tester.tap(find.byType(ElevatedButton));

    await tester.pumpAndSettle();

    expect(find.byType(AddNotes), findsOneWidget);
  });

  testWidgets("Inserting notes and checking if it is added in the notes list",
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));

    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const ValueKey('Title Key')), 'New Book');

    await tester.enterText(
        find.byKey(const ValueKey('Description Key')), 'Elon');

    await tester.ensureVisible(find.byType(ElevatedButton));

    await tester.pumpAndSettle();

    await tester.tap(find.byType(ElevatedButton));

    await tester.pumpAndSettle();
  });

  testWidgets("Updating notes and checking if it is updated in the notes list",
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.edit));

    await tester.pumpAndSettle();

    await tester.enterText(
        find.byKey(const ValueKey('Updated Title Key')), 'New Book By');

    await tester.enterText(
        find.byKey(const ValueKey('Updated Desc Key')), 'Elon Musk');

    await tester.ensureVisible(find.byType(ElevatedButton));

    await tester.pumpAndSettle();

    await tester.tap(find.byType(ElevatedButton));

    await tester.pumpAndSettle();

    expect(find.byType(NotesScreen), findsOneWidget);

    final state = tester.state(find.byType(Scaffold));

    final notes = state.context.read<NotesStore>().notesList[0];

    expect(find.text(notes.title), findsOneWidget);

    expect(find.text(notes.description), findsOneWidget);
  });

  testWidgets("Deleting notes and checking if it is deleted in the notes list",
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.pumpAndSettle();

    final state = tester.state(find.byType(Scaffold));

    final title = state.context.read<NotesStore>().notesList[0].title;

    await tester.tap(find.byIcon(Icons.delete));

    await tester.pumpAndSettle();

    expect(find.text(title), findsNothing);
  });
}
