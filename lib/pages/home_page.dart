import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasky_note/models/note.dart';
import 'package:tasky_note/pages/add_note_page.dart';
import 'package:tasky_note/widget/note_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Note> _notes = [];

  void _addNote(String title) {
    setState(() {
      _notes.add(Note(title: title));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: _notes.isEmpty
      ? const Center(child: Text('Belum Ada Catatan'),)
          : ListView.builder(itemCount: _notes.length,
        itemBuilder: (context, index) {
            return NoteItem(note: _notes[index], onToggle: () {
              setState(() {
                _notes[index].isDone = !_notes[index].isDone;
              });
            }, onDelete: () {
              setState(() {
                _notes.removeAt(index);
              });
            });
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNotePage()));
        if(result != null){
          _addNote(result);
        }
      },
        child: const Icon(Icons.add),
      ),
    );
  }

}