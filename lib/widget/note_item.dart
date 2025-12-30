import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasky_note/models/note.dart';
import 'package:tasky_note/pages/note_detail_page.dart';

class NoteItem extends StatelessWidget {
  final Note noteData;
  final VoidCallback onEdti;
  final VoidCallback onDelte;

  const NoteItem({
    super.key,
    required this.noteData,
    required this.onEdti,
    required this.onDelte,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => NoteDetailPage(note: noteData),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border(
            left: BorderSide(
              color: noteData.color,
              width: 4,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER (DATE + MENU)
              Row(
                children: [
                  Expanded(child: _dateLable()),
                  PopupMenuButton<String>(
                    splashRadius: 18,
                    onSelected: (menuValue) {
                      if (menuValue == 'edit') onEdti();
                      if (menuValue == 'delete') onDelte();
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, size: 18),
                            SizedBox(width: 8),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete,
                              size: 18,
                              color: Colors.red,
                            ),
                            SizedBox(width: 8),
                            Text('Delete'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 14),

              /// TITLE
              Text(
                noteData.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 14),

              /// INFO ROW (RESPONSIVE)
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: [
                  _informationItem(
                    itemColor: noteData.color,
                    itemIcon: Icons.access_time,
                    itemLable: 'Waktu',
                    itemValue: _timeLableText(context),
                  ),
                  _informationItem(
                    itemColor: Colors.grey,
                    itemIcon: Icons.category,
                    itemLable: 'Kategori',
                    itemValue: noteData.category,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= DATE LABEL =================
  Widget _dateLable() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            noteData.color.withOpacity(0.15),
            noteData.color.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_today,
            size: 14,
            color: noteData.color,
          ),
          const SizedBox(width: 6),
          Text(
            DateFormat('dd MMM yyyy').format(noteData.date),
            style: TextStyle(
              fontSize: 12,
              color: noteData.color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ================= INFO ITEM =================
  Widget _informationItem({
    required Color itemColor,
    required IconData itemIcon,
    required String itemLable,
    required String itemValue,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: itemColor.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(
            itemIcon,
            size: 14,
            color: itemColor,
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              itemLable,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
            ),
            Text(
              itemValue,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: itemColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _timeLableText(BuildContext context) {
    if (noteData.startTime == null && noteData.endTime == null) return '-';

    final startTimeText =
        noteData.startTime?.format(context) ?? '--:--';
    final endTimeText =
        noteData.endTime?.format(context) ?? '--:--';

    return '$startTimeText - $endTimeText';
  }
}
