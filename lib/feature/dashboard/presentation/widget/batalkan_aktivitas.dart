import 'package:flutter/material.dart';
import 'package:mam/feature/dashboard/model/aktivitas_base_model.dart';

class BatalkanAktivitas extends StatelessWidget {
  final AktivitasBase aktivitas;

  const BatalkanAktivitas({
    super.key,
    required this.aktivitas,
  });

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    DateTime aktivitasDate = aktivitas.date;

    // Normalize to remove time for accurate day comparison
    DateTime todayOnly = DateTime(today.year, today.month, today.day);
    DateTime aktivitasOnly =
        DateTime(aktivitasDate.year, aktivitasDate.month, aktivitasDate.day);

    aktivitasOnly.isAfter(todayOnly);
    aktivitasOnly.isBefore(todayOnly);

    return Scaffold(
      appBar: AppBar(title: const Text('Pembatalan Aktivitas')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Card for Activity Details
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Table(
                  columnWidths: const {
                    0: FixedColumnWidth(100), // Set a fixed width for labels
                    1: FixedColumnWidth(10), // Small space for the colon
                    2: FlexColumnWidth(), // Value takes remaining space
                  },
                  children: [
                    _buildTableRow('Title', aktivitas.title),
                    _buildTableRow('Description', aktivitas.description),
                    _buildTableRow('Date', aktivitas.date.toLocal().toString()),
                    _buildTableRow('Location', aktivitas.location),
                    _buildTableRow('Organizer', aktivitas.organizer),
                    _buildTableRow('Time', (aktivitas.time)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Long Text Field for Cancellation Reason
            TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Alasan pembatalan",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Handle cancellation submission
                },
                child: const Text("Batalkan Aktivitas",
                    style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String field, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(
            field,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 6),
          child: Text(":", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Text(value),
        ),
      ],
    );
  }
}
