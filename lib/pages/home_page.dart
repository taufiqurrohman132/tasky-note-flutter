import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasky_note/models/note.dart';
import 'package:tasky_note/pages/add_note_page.dart';
import 'package:tasky_note/widget/note_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Note> _notes = [];

  int get todayCount {
    final now = DateTime.now();
    return _notes.where((n) =>
    n.date.year == now.year &&
        n.date.month == now.month &&
        n.date.day == now.day
    ).length;
  }

  int get scheduleCount {
    final now = DateTime.now();
    return _notes.where((n) => n.date.isAfter(now)).length;
  }

  int get projectCount {
    return _notes.where((n) => n.category == 'project').length;
  }

  int get allTaskCount => _notes.length;


  void _addNote(Note note) {
    setState(() {
      _notes.add(note);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(),
                const SizedBox(height: 20),
                _overview(),
                const SizedBox(height: 24),
                _projectTitle(),
                const SizedBox(height: 12),
                _noteList(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddNotePage()),
          );
          if (result is Note) {
            _addNote(result);
          }


        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Welcome',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 4),
            Text(
              'Andrew Mike',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none),
            ),
            const CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('assets/avatar.png'),
            ),
          ],
        )
      ],
    );
  }
  Widget _overview() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _overviewCard(todayCount.toString(), 'Today', Colors.purple),
        _overviewCard(scheduleCount.toString(), 'Schedule', Colors.orange),
        _overviewCard(projectCount.toString(), 'Projects', Colors.blue),
        _overviewCard(allTaskCount.toString(), 'All Task', Colors.green),
      ],
    );
  }


  Widget _overviewCard(String value, String title, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(title),
        ],
      ),
    );
  }
  Widget _projectTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'Projects',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          'All time',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
  Widget _noteList() {
    if (_notes.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 40),
          child: Text('Belum Ada Catatan'),
        ),
      );
    }

    return ListView.builder(
      itemCount: _notes.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final note = _notes[index]; // ⬅️ INI ASALNYA

        return NoteItem(
          note: note,
          onEdit: () {
            // buka halaman edit
          },
          onDelete: () {
            setState(() {
              _notes.remove(note);
            });
          },
        );

      },
    );
  }

}