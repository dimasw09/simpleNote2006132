import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../models/note.dart';

class DatabaseService {
  final String boxName = 'noteBox';
  Future<void> addNote(Note note) async {
    final box = await Hive.openBox(boxName);
    await box.add(note);
  }

  Future<List<Note>> getAllNotes() async {
    final box = await Hive.openBox(boxName);
    return box.values.toList().cast<Note>();
  }

  Future<void> updateNote(int key, Note note) async {
    final box = await Hive.box(boxName);
    await box.put(key, note);
  }

  Future<void> deleteNote(Note note) async {
    final box = await Hive.openBox(boxName);
    await box.delete(note.key);
  }
}
