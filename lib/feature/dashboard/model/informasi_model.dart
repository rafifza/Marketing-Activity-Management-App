class InformasiModel {
  final String title;
  final String description;
  final DateTime date;
  final String location;
  final String organizer;
  final String isCompleted;

  InformasiModel({
    required this.title,
    required this.description,
    required this.date,
    required this.location,
    required this.organizer,
    required this.isCompleted,
  });
}

final List<InformasiModel> informasiDummy = [
  InformasiModel(
    title: 'Meeting with Client A',
    description: 'Discuss project requirements and timelines.',
    date: DateTime.now(),
    location: 'Office',
    organizer: 'John Doe',
    isCompleted: 'false',
  ),
  InformasiModel(
    title: 'Code Review Session',
    description: 'Review the latest code commits.',
    date: DateTime.now().add(Duration(days: 1)),
    location: 'Conference Room',
    organizer: 'Jane Smith',
    isCompleted: 'false',
  ),
  InformasiModel(
    title: 'Design Workshop',
    description: 'Collaborate on the new UI design.',
    date: DateTime.now().add(Duration(days: 2)),
    location: 'Design Lab',
    organizer: 'Emily Johnson',
    isCompleted: 'true',
  ),
  InformasiModel(
    title: 'Project Kickoff',
    description: 'Initiate the new project with the team.',
    date: DateTime.now().add(Duration(days: 3)),
    location: 'Main Hall',
    organizer: 'Michael Brown',
    isCompleted: 'false',
  ),
  InformasiModel(
    title: 'Client Feedback Review',
    description: 'Analyze feedback from Client B.',
    date: DateTime.now().add(Duration(days: 4)),
    location: 'Meeting Room 2',
    organizer: 'Chris Davis',
    isCompleted: 'yees',
  ),
  InformasiModel(
    title: 'Sprint Planning',
    description: 'Plan tasks for the upcoming sprint.',
    date: DateTime.now().add(Duration(days: 5)),
    location: 'Scrum Room',
    organizer: 'Patricia Wilson',
    isCompleted: 'yes',
  ),
];
