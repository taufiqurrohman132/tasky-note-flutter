import 'package:flutter/material.dart';
import 'package:tasky_note/models/note.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  DateTime pickedDate = DateTime.now();
  TimeOfDay startTm = TimeOfDay.now();
  TimeOfDay endTm = TimeOfDay.now();

  Color pickedClr = Colors.blue;
  String cat = 'task';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f7fb),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create New Task',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),

            _box(
              'Topic',
              TextField(
                controller: titleCtrl,
                decoration: const InputDecoration(
                  hintText: 'Write topic',
                  border: InputBorder.none,
                ),
              ),
            ),

            _box(
              'Description',
              TextField(
                controller: descCtrl,
                minLines: 2,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Write description',
                  border: InputBorder.none,
                ),
              ),
            ),

            _box(
              'Date',
              InkWell(
                onTap: () async {
                  final d = await showDatePicker(
                    context: context,
                    initialDate: pickedDate,
                    firstDate: DateTime(2021),
                    lastDate: DateTime(2100),
                  );
                  if (d != null) {
                    setState(() => pickedDate = d);
                  }
                },
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 17),
                    const SizedBox(width: 8),
                    Text(
                      '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}',
                    ),
                  ],
                ),
              ),
            ),

            _box(
              'Time',
              Row(
                children: [
                  Expanded(child: _timePick('Start', startTm, true)),
                  const SizedBox(width: 10),
                  Expanded(child: _timePick('End', endTm, false)),
                ],
              ),
            ),

            _box(
              'Color',
              Row(
                children: [
                  _clrDot(Colors.blue),
                  _clrDot(Colors.purple),
                  _clrDot(Colors.orange),
                  _clrDot(Colors.green),
                ],
              ),
            ),

            _box(
              'Category',
              Wrap(
                spacing: 8,
                children: ['task', 'event', 'reminder', 'project']
                    .map((e) => ChoiceChip(
                  label: Text(e),
                  selected: cat == e,
                  onSelected: (_) {
                    setState(() => cat = e);
                  },
                ))
                    .toList(),
              ),
            ),

            const SizedBox(height: 26),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text('Save Task'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _box(String title, Widget child) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              )),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget _timePick(String label, TimeOfDay tm, bool isStart) {
    return InkWell(
      onTap: () async {
        final t = await showTimePicker(
          context: context,
          initialTime: tm,
        );
        if (t != null) {
          setState(() {
            if (isStart) {
              startTm = t;
            } else {
              endTm = t;
            }
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Row(
          children: [
            const Icon(Icons.access_time, size: 17),
            const SizedBox(width: 6),
            Text('$label: ${tm.format(context)}'),
          ],
        ),
      ),
    );
  }

  Widget _clrDot(Color c) {
    final active = pickedClr == c;
    return GestureDetector(
      onTap: () => setState(() => pickedClr = c),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: c,
          shape: BoxShape.circle,
          border: active
              ? Border.all(color: Colors.black, width: 2)
              : null,
        ),
      ),
    );
  }

  void _save() {
    final t = titleCtrl.text.trim();
    if (t.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Judul belum diisi')),
      );
      return;
    }

    Navigator.pop(
      context,
      Note(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: t,
        description: descCtrl.text.trim().isEmpty ? null : descCtrl.text,
        date: pickedDate,
        startTime: startTm,
        endTime: endTm,
        isDone: false,
        category: cat,
        color: pickedClr,
      ),
    );
  }
}
