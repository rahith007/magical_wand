import 'package:flutter/material.dart';
import 'package:magical_wand/models/note_model.dart';
import 'package:magical_wand/pages/details_page.dart';
import 'package:magical_wand/service/note_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.grey,
        child: Icon(Icons.add_circle_outline_rounded, color: Colors.black),
      ),
      body: FutureBuilder<List<NotepadResponseModel>>(
        future: NoteService().getNotes(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white10,
              ),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            if (data.isEmpty) {
              return Text("no notes available");
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: data.map((e) {
                    return _NotesContainerWidget(notePad: e);
                  }).toList(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class _NotesContainerWidget extends StatelessWidget {
  final NotepadResponseModel notePad;
  const _NotesContainerWidget({required this.notePad});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NoteDetailsPage(noteId: notePad.id),
          ),
        );
      },
      onDoubleTap: () {
        NoteService().pinOrUnpinNotepad(noteId: notePad.id);
      },
      onLongPress: () {
        NoteService().deleteNote(noteId: notePad.id);
      },
      child: Container(
        height: 160,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Text(
              notePad.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              notePad.content,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
