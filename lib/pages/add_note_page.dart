import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_note/services/database_service.dart';

import '../models/note.dart';

class AddNotePage extends StatefulWidget {
  final Note? note;

  const AddNotePage({Key? key, this.note}) : super(key: key);

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final DatabaseService dbService = DatabaseService();
  late TextEditingController _titleCtrl;
  late TextEditingController _descriptionCtrl;
  @override
  void initState() {
    _titleCtrl = TextEditingController();
    _descriptionCtrl = TextEditingController();
    if (widget.note != null) {
      _titleCtrl.text = widget.note!.title;
      _descriptionCtrl.text = widget.note!.desc;
    }

    super.initState();
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descriptionCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.note != null ? "Edit Note" : "Edit Note"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextFormField(
              controller: _titleCtrl,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                hintText: "Title",
                border: InputBorder.none,
              ),
            ),
            // const Divider(thickness: 1),
            TextFormField(
              keyboardType: TextInputType.multiline,
              controller: _descriptionCtrl,
              minLines: null,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: "Description",
                border: InputBorder.none,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Note note = Note(
              title: _titleCtrl.text,
              desc: _descriptionCtrl.text,
              createdAt: DateTime.now().toIso8601String());

          if (widget.note != null) {
            await DatabaseService().updateNote(widget.note!.key, note);
            GoRouter.of(context).pop(); //To call edit note
          } else {
            await DatabaseService().addNote(note);
            GoRouter.of(context).pop();
          }
        },
        label: const Text("Save Note"),
      ),
    );
  }
}
