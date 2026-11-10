import 'package:flutter/material.dart';

class NotepadPage extends StatefulWidget {
  const NotepadPage({super.key});

  @override
  State<NotepadPage> createState() => _NotepadPageState();
}

class _NotepadPageState extends State<NotepadPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  List<Map<String, String>> notes = [];

  int? editingIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notepad")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                hintText: "Enter note title",
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: contentController,
              maxLines: 8,
              decoration: const InputDecoration(
                labelText: "Content",
                hintText: "Write your note",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (titleController.text.isEmpty ||
                          contentController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please enter title and content"),
                          ),
                        );
                        return;
                      }

                      if (editingIndex == null) {
                        setState(() {
                          notes.add({
                            "title": titleController.text,
                            "content": contentController.text,
                          });
                        });
                      } else {
                        setState(() {
                          notes[editingIndex!] = {
                            "title": titleController.text,
                            "content": contentController.text,
                          };

                          editingIndex = null;
                        });
                      }

                      titleController.clear();
                      contentController.clear();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Note saved successfully"),
                        ),
                      );
                    },
                    child: const Text("Save Note"),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      titleController.clear();
                      contentController.clear();

                      setState(() {
                        editingIndex = null;
                      });
                    },
                    child: const Text("Cancel"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(notes[index]["title"]!),
                    subtitle: Text(notes[index]["content"]!),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            titleController.text = notes[index]["title"]!;

                            contentController.text = notes[index]["content"]!;

                            setState(() {
                              editingIndex = index;
                            });
                          },
                          icon: const Icon(Icons.edit),
                        ),

                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Delete Note"),
                                  content: const Text(
                                    "Are you sure you want to delete this note?",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Cancel"),
                                    ),

                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          notes.removeAt(index);
                                        });

                                        Navigator.pop(context);
                                      },
                                      child: const Text("Delete"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        
                
              
            
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
