import 'package:flutter/material.dart';
import 'package:myapp/add_note.dart';
import 'package:myapp/edit_note.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> notes = [];
  List<bool> lockedNotes = []; // Track locked status of notes

  void _addNewNote() async {
    final String? newNote = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddNoteScreen()),
    );
    if (newNote != null) {
      setState(() {
        notes.add(newNote);
        lockedNotes.add(false); // New notes are not locked by default
      });
    }
  }

  void _viewNoteDetails(String note, int index) async {
    final updatedNote = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNoteScreen(
          note: note,
          index: index,
        ),
      ),
    );
    if (updatedNote != null) {
      setState(() {
        notes[index] = updatedNote;
      });
    }
  }

  void _showOptions(int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Delete Note'),
              onTap: () {
                setState(() {
                  notes.removeAt(index);
                  lockedNotes.removeAt(index);
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock),
              title: Text(lockedNotes[index] ? 'Unlock Note' : 'Lock Note'),
              onTap: () {
                setState(() {
                  lockedNotes[index] = !lockedNotes[index];
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Colors.lightGreen,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.green.shade50,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onLongPress: () => _showOptions(index),
                        onTap: () => _viewNoteDetails(notes[index], index),
                        child: Card(
                          margin: const EdgeInsets.all(8.0),
                          elevation: 5,
                          child: ListTile(
                            title: Text(
                              notes[index],
                              maxLines: 2, // Display only the first 2 lines
                              overflow: TextOverflow.ellipsis, // Truncate text with ellipsis
                            ),
                            subtitle: Text(lockedNotes[index] ? 'Locked' : 'Unlocked'),
                            contentPadding: const EdgeInsets.all(16.0),
                            trailing: Icon(
                              lockedNotes[index] ? Icons.lock : Icons.lock_open,
                              color: lockedNotes[index] ? Colors.red : Colors.green,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Container(
                //   color: Colors.lightGreen,
                //   padding: const EdgeInsets.all(8.0),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: TextButton(
                //           onPressed: () {
                //             // Navigate to the Notes screen (current screen)
                //           },
                //           child: texDesign('Notes'),
                //         ),
                //       ),
                //       Expanded(
                //         child: TextButton(
                //           onPressed: () {
                //             // Navigate to the To Do screen
                //             Navigator.push(
                //               context,
                //               MaterialPageRoute(builder: (context) => const ToDoScreen()),
                //             );
                //           },
                //           child: texDesign('Todo'),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
            Positioned(
              bottom: 70.0,
              right: 16.0,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.lightGreen,
                ),
                child: IconButton(
                  icon: const Icon(Icons.add, size: 40),
                  color: Colors.white,
                  onPressed: _addNewNote,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text texDesign(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 15),
    );
  }
}
