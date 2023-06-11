import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_note/models/note.dart';
import 'package:simple_note/services/database_service.dart';

import '../component/card_note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService dbService = DatabaseService();
  final GlobalKey<ScaffoldState> _sKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _sKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Simple Note Apps",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ValueListenableBuilder(
          valueListenable: Hive.box('noteBox').listenable(),
          builder: (context, box, child) {
            if (box.values.isEmpty) {
              return const Center(
                child: Text('tidak ada catatan'),
              );
            } else {
              return ListView.builder(
                itemCount: box.length,
                itemBuilder: (context, index) {
                  Note currentNote = box.getAt(index);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Dismissible(
                        key: Key(currentNote.key.toString()),
                        onDismissed: (_) {
                          dbService.deleteNote(currentNote).then((_) => {
                                ScaffoldMessenger.of(_sKey.currentContext!)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      'Catatan ${currentNote.key} Dihapus'),
                                )),
                              });
                        },
                        child: CardNote(note: currentNote)),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.pushNamed('addNote');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('DatabaseService', DatabaseService));
    properties.add(DiagnosticsProperty('DatabaseService', DatabaseService));
  }
}
