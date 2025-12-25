import 'package:flutter/material.dart';
import 'package:tasky_note/models/note.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  String _selectedCategory = 'task';

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();

  Color _selectedColor = Colors.blue;
  String _category = 'task';



  Future<void> _pickStartTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null) setState(() => _startTime = time);
  }

  Future<void> _pickEndTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _startTime ?? TimeOfDay.now(),
    );
    if (time != null) setState(() => _endTime = time);
  }

  void _saveNote() {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Judul wajib diisi')),
      );
      return;
    }

    Navigator.pop(
      context,
      Note(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        description: _descController.text.isEmpty
            ? null
            : _descController.text,
        date: _selectedDate,
        startTime: _startTime,
        endTime: _endTime,
        isDone: false,
        category: _category,
        color: _selectedColor,
      ),
    );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create New Task',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            /// TOPIC
            const Text('Topic', style: TextStyle(color: Colors.grey)),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Write topic',
                border: UnderlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            /// DESCRIPTION
            const Text('Description', style: TextStyle(color: Colors.grey)),
            TextField(
              controller: _descController,
              minLines: 1,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Write description',
                border: UnderlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            /// DATE
            const Text('Date', style: TextStyle(color: Colors.grey)),
            InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  setState(() => _selectedDate = picked);
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  '${_selectedDate.day} / ${_selectedDate.month} / ${_selectedDate.year}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// TIME
            const Text('Time', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _timeField(
                    label: 'Start',
                    time: _startTime,
                    onTap: _pickStartTime,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _timeField(
                    label: 'End',
                    time: _endTime,
                    onTap: _pickEndTime,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// COLOR
            const Text('Choose color', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Row(
              children: [
                _colorDot(Colors.blue),
                _colorDot(Colors.purple),
                _colorDot(Colors.orange),
                _colorDot(Colors.green),
              ],
            ),

            const SizedBox(height: 24),

            /// CATEGORY
            const Text('Category', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                _categoryChip('task'),
                _categoryChip('event'),
                _categoryChip('reminder'),
                _categoryChip('project'),
              ],
            ),

            const SizedBox(height: 32),

            /// SAVE BUTTON
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _saveNote,
                style: ElevatedButton.styleFrom(
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

  Widget _colorDot(Color color) {
    return GestureDetector(
      onTap: () => setState(() => _selectedColor = color),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: _selectedColor == color
                ? Colors.black
                : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }
  Widget _categoryChip(String value) {
    final isSelected = _category == value;

    return ChoiceChip(
      label: Text(value),
      selected: isSelected,
      onSelected: (_) {
        setState(() => _category = value);
      },
    );
  }

  Widget _timeField({
    required String label,
    required TimeOfDay? time,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: UnderlineInputBorder(),
        ),
        child: Text(
          time == null ? '--:--' : time.format(context),
        ),
      ),
    );
  }




}
