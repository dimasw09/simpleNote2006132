import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_note/models/note.dart';
import 'package:simple_note/utils/routes.dart';

class CardNote extends StatelessWidget {
  final Note note;
  const CardNote({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        GoRouter.of(context).pushNamed(Approutes.editNote, extra: note);
      },
      tileColor: Color.fromARGB(255, 238, 255, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(note.title),
      subtitle: Text(note.desc),
      trailing: Text(
        note.createdAt,
        style: TextStyle(fontSize: 10),
      ),
    );
  }
}
