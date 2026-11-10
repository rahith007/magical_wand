import 'package:flutter/material.dart';
import 'package:magical_wand/service/note_service.dart';
import '../models/note_details_model.dart';

class NoteDetailsPage extends StatelessWidget {
  final String noteId;

  const NoteDetailsPage({super.key, required this.noteId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Note Details')),

      body: FutureBuilder<DetailsModel>(
        future: NoteService().getNotePadDetails(id: noteId),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white12,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (snapshot.hasData) {
            final note = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Text(note.content, style: const TextStyle(fontSize: 16)),

                  const SizedBox(height: 20),

                  const Text(
                    'Tags',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  if (note.tags != null)
                    Wrap(
                      spacing: 8,
                      children: note.tags!
                          .map((tag) => Chip(label: Text(tag)))
                          .toList(),
                    ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Icon(
                        note.isPinned
                            ? Icons.push_pin
                            : Icons.push_pin_outlined,
                      ),
                      const SizedBox(width: 8),
                      Text(note.isPinned ? 'Pinned' : 'Not Pinned'),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
      ),
    );
  }
}
