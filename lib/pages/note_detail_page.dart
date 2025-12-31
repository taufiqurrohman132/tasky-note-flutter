import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/note.dart';

class NoteDetailPage extends StatelessWidget {
  final Note note;

  const NoteDetailPage({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: SizedBox(
            // width: contenWidth,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _topNavigation(context),
                      const SizedBox(height: 26),
                      _headerSection(),
                      const SizedBox(height: 26),
                      _informationGrid(context),
                      if (note.description != null &&
                          note.description!.trim().isNotEmpty) ...[
                        const SizedBox(height: 26),
                        _desriptionSection(),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _topNavigation(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
        const SizedBox(width: 6),
        const Text(
          'Task Detail',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _headerSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [note.color.withOpacity(0.34), note.color.withOpacity(0.09)],
        ),
        borderRadius: BorderRadius.circular(27),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cateogryBadge(),
          const SizedBox(height: 17),
          Text(
            note.title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }

  Widget _cateogryBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: note.color,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: note.color.withOpacity(0.38),
            blurRadius: 11,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Text(
        note.category.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.7,
        ),
      ),
    );
  }

  Widget _informationGrid(BuildContext context) {
    final isWideLayout = MediaQuery.of(context).size.width > 720;

    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isWideLayout ? 2 : 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: isWideLayout ? 3.5 : 3,
          ),
          children: [
            _informationCard(
              icon: Icons.calendar_month,
              title: 'Tanggal',
              value: DateFormat('dd MMM yyyy').format(note.date),
            ),
            _informationCard(
              icon: Icons.access_time,
              title: 'Waktu',
              value: _timeDisplayText(context),
            ),
            _informationCard(
              icon: Icons.flag_outlined,
              title: 'Status',
              value: note.isDone ? 'Selesai' : 'Belum selesai',
              valueColor: note.isDone ? Colors.green : Colors.orange,
            ),
            _informationCard(
              icon: Icons.palette_outlined,
              title: 'Warna',
              value: 'Custom',
              valueColor: note.color,
            ),
          ],
        );
      },
    );
  }

  Widget _informationCard({
    required IconData icon,
    required String title,
    required String value,
    Color? valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(23),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.055),
            blurRadius: 20,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: note.color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: note.color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: valueColor ?? Colors.black,
                      ),
                    ),
                    if (title == 'Warna') ...[
                      const SizedBox(width: 8),
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: note.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _timeDisplayText(BuildContext context) {
    if (note.startTime == null && note.endTime == null) return '-';

    final startTimeText = note.startTime?.format(context) ?? '--:--';
    final endTimeText = note.endTime?.format(context) ?? '--:--';

    return '$startTimeText - $endTimeText';
  }

  Widget _desriptionSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.055),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Deskripsi',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            note.description!,
            style: const TextStyle(
              fontSize: 14,
              height: 1.6,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
