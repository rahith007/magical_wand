import 'package:flutter/material.dart';
import 'package:magical_wand/service/note_service.dart';

class NotepadInsertPage extends StatefulWidget {
  const NotepadInsertPage({super.key});

  @override
  State<NotepadInsertPage> createState() => _NotepadInsertPageState();
}

class _NotepadInsertPageState extends State<NotepadInsertPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final tagsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('notepad Insert')),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: "Content"),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: tagsController,
              decoration: const InputDecoration(labelText: "Tags"),
            ),
            Text('separte With Comma'),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: () async {
                if (titleController.text.isEmpty ||
                    contentController.text.isEmpty ||
                    tagsController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("pleaae enter all data")),
                  );
                  return;
                }
                await NoteService().insertNote(
                  title: titleController.text,
                  content: contentController.text,
                  tags: tagsController.text,
                );
              },
              child: const Text("Create note"),
            ),
          ],
        ),
      ),
    );
  }
}
