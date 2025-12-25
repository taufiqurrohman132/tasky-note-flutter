import 'dart:ui';

import 'package:flutter/material.dart';

class Note {
  final String id;
  final String title;
  final String? description;
  final DateTime date;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  bool isDone;
  final String category; // event, reminder, milestone
  final Color color;

  Note({
    required this.id,
    required this.title,
    this.description,
    required this.date,
    this.startTime,
    this.endTime,
    this.isDone = false,
    required this.category,
    required this.color,
  });
}
