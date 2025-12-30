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
    return _notes
        .where(
          (n) =>
              n.date.year == now.year &&
              n.date.month == now.month &&
              n.date.day == now.day,
        )
        .length;
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
    final horizontalPadding = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1100, // batas lebar desktop
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 16,
                ),
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
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddNotePage()),
          );
          if (result is Note) {
            _addNote(result);
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('New Task'),
      ),
    );
  }

  // headerd
  Widget _header() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6A5AE0), Color(0xFF8E7BFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Welcome back', style: TextStyle(color: Colors.white70)),
              SizedBox(height: 4),
              Text(
                'Tasky Note',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none, color: Colors.white),
              ),
              const CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage('assets/avatar.png'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // card 4
  Widget _overview() {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxis = screenWidth > 600 ? 4 : 2;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxis,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        mainAxisExtent: 110, // tinggi card FIX & aman di HP
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      itemBuilder: (context, index) {
        final items = [
          _overviewCard(
            todayCount.toString(),
            'Today',
            Icons.today,
            Colors.purple,
          ),
          _overviewCard(
            scheduleCount.toString(),
            'Schedule',
            Icons.schedule,
            Colors.orange,
          ),
          _overviewCard(
            projectCount.toString(),
            'Projects',
            Icons.work,
            Colors.blue,
          ),
          _overviewCard(
            allTaskCount.toString(),
            'All Task',
            Icons.task,
            Colors.green,
          ),
        ];
        return items[index];
      },
    );
  }

  Widget _overviewCard(
      String value,
      String title,
      IconData icon,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// ICON
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22),
          ),

          const SizedBox(width: 10),

          /// TEXT (WAJIB Expanded)
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
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
        Chip(label: Text('All time'), backgroundColor: Color(0xFFEDEAFF)),
      ],
    );
  }

  Widget _noteList() {
    if (_notes.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 40),
        child: Center(child: Text('Belum Ada Catatan')),
      );
    }

    return ListView.builder(
      itemCount: _notes.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final note = _notes[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Card(
            elevation: 4,
            shadowColor: Colors.black12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: NoteItem(
              noteData: note,
              onEdti: () {},
              onDelte: () {
                setState(() {
                  _notes.remove(note);
                });
              },
            ),
          ),
        );
      },
    );
  }
}
