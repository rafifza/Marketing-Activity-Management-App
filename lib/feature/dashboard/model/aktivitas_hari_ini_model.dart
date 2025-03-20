import 'package:intl/intl.dart';
import 'package:mam/feature/dashboard/model/aktivitas_base_model.dart';

class AktivitasHariIniModel implements AktivitasBase {
  @override
  final String title;
  @override
  final String description;
  @override
  final DateTime date;
  @override
  final String location;
  @override
  final String organizer;
  @override
  final String time; // Now holds dynamically adjusted time

  AktivitasHariIniModel({
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.organizer,
    required this.time, // Time is formatted and calculated dynamically
  });

  /// Returns formatted date as dd/MM/yyyy
  String get formattedDate => DateFormat('dd/MM/yyyy').format(date);

  /// Static method to get formatted time with offset
  static String getTimeWithOffset(int hoursOffset) {
    final now = DateTime.now().add(Duration(hours: hoursOffset));
    return DateFormat('HH:mm').format(now);
  }
}

final List<AktivitasHariIniModel> dummyAktivitasHariIni = [
  AktivitasHariIniModel(
    title: 'Meeting with Client A',
    description: 'Discuss project requirements and timelines.',
    date: DateTime.now(),
    location: 'Office',
    organizer: 'John Doe',
    time: AktivitasHariIniModel.getTimeWithOffset(0), // Now
  ),
  AktivitasHariIniModel(
    title: 'Code Review Session',
    description: 'Review the latest code commits.',
    date: DateTime.now().subtract(Duration(days: 1)),
    location: 'Conference Room',
    organizer: 'Jane Smith',
    time: AktivitasHariIniModel.getTimeWithOffset(-1), // Now - 1 hour
  ),
  AktivitasHariIniModel(
    title: 'Design Workshop',
    description: 'Collaborate on the new UI design.',
    date: DateTime.now().subtract(Duration(days: 2)),
    location: 'Design Lab',
    organizer: 'Emily Johnson',
    time: AktivitasHariIniModel.getTimeWithOffset(-2), // Now - 2 hours
  ),
  AktivitasHariIniModel(
    title: 'Project Kickoff',
    description: 'Initiate the new project with the team.',
    date: DateTime.now().add(Duration(days: 3)),
    location: 'Main Hall',
    organizer: 'Michael Brown',
    time: AktivitasHariIniModel.getTimeWithOffset(1), // Now + 1 hour
  ),
  AktivitasHariIniModel(
    title: 'Client Feedback Review',
    description: 'Analyze feedback from Client B.',
    date: DateTime.now().add(Duration(days: 4)),
    location: 'Meeting Room 2',
    organizer: 'Chris Davis',
    time: AktivitasHariIniModel.getTimeWithOffset(2), // Now + 2 hours
  ),
];
