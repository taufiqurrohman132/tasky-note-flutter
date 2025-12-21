import 'package:flutter/material.dart';
import 'package:tasky_note/models/note.dart';

class NoteItem extends StatelessWidget {
  final Note note;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const NoteItem({
    super.key,
    required this.note,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          value: note.isDone,
          onChanged: (_) => onToggle(),
        ),
        title: Text(
          note.title,
          style: TextStyle(
            decoration:
            note.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onDelete,
        ),
      ),
    );
  }
}

