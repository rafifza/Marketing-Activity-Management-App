import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryAbsenModel {
  final DateTime date;
  final String day;
  final TimeOfDay checkInTime;
  final TimeOfDay checkOutTime;

  HistoryAbsenModel({
    required this.date,
    required this.day,
    required this.checkInTime,
    required this.checkOutTime,
  });
  String get formattedDate => DateFormat('dd/MM/yyyy').format(date);
}

final List<HistoryAbsenModel> dummyHistoryAbsen = [
  HistoryAbsenModel(
    date: DateTime.now(),
    day: 'Senin',
    checkInTime: TimeOfDay(hour: 10, minute: 10),
    checkOutTime: TimeOfDay(hour: 17, minute: 10),
  ),
  HistoryAbsenModel(
    date: DateTime.now(),
    day: 'Selasa',
    checkInTime: TimeOfDay(hour: 10, minute: 10),
    checkOutTime: TimeOfDay(hour: 17, minute: 10),
  ),
  HistoryAbsenModel(
    date: DateTime.now(),
    day: 'Rabu',
    checkInTime: TimeOfDay(hour: 10, minute: 10),
    checkOutTime: TimeOfDay(hour: 17, minute: 10),
  ),
  HistoryAbsenModel(
    date: DateTime.now(),
    day: 'Kamis',
    checkInTime: TimeOfDay(hour: 10, minute: 10),
    checkOutTime: TimeOfDay(hour: 17, minute: 10),
  ),
  HistoryAbsenModel(
    date: DateTime.now(),
    day: 'Jumat',
    checkInTime: TimeOfDay(hour: 10, minute: 10),
    checkOutTime: TimeOfDay(hour: 17, minute: 10),
  ),
  HistoryAbsenModel(
    date: DateTime.now(),
    day: 'Sabtu',
    checkInTime: TimeOfDay(hour: 10, minute: 10),
    checkOutTime: TimeOfDay(hour: 17, minute: 10),
  ),
];
