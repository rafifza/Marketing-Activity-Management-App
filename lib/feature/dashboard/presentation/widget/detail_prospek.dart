import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mam/core/routes/app_route.dart';
import 'package:mam/feature/dashboard/model/aktivitas_base_model.dart';
import 'package:mam/feature/dashboard/model/daftar_prospek_model.dart';

class DetailProspek extends StatelessWidget {
  final DaftarProspekModel daftarProspek;
  const DetailProspek({
    super.key,
    required this.daftarProspek,
  });

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();
    DateTime aktivitasDate = daftarProspek.date;

    // Normalize to remove time for accurate day comparison
    DateTime todayOnly = DateTime(today.year, today.month, today.day);
    DateTime aktivitasOnly =
        DateTime(aktivitasDate.year, aktivitasDate.month, aktivitasDate.day);

    bool isFutureDate = aktivitasOnly.isAfter(todayOnly);
    bool isPastDate = aktivitasOnly.isBefore(todayOnly);

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Prospek')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // Makes elements stretch full width
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
                    0: FixedColumnWidth(120), // Set a fixed width for labels
                    1: FixedColumnWidth(10), // Small space for the colon
                    2: FlexColumnWidth(), // Value takes remaining space
                  },
                  children: [
                    _buildTableRow('Nama', daftarProspek.title),
                    _buildTableRow('Kategori Polis', daftarProspek.description),
                    _buildTableRow('Jenis Asuransi',
                        daftarProspek.date.toLocal().toString()),
                    _buildTableRow('Obyek Asuransi', daftarProspek.location),
                    _buildTableRow('TSI', daftarProspek.organizer),
                    _buildTableRow('TSI', daftarProspek.organizer),
                    _buildTableRow('Estimasi Premi', daftarProspek.organizer),
                    _buildTableRow('Status Prospek', daftarProspek.organizer),
                    _buildTableRow('No Polis', daftarProspek.organizer),
                    _buildTableRow('Premi', daftarProspek.organizer),
                    _buildTableRow('Catatan', daftarProspek.organizer),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Buttons Section (Stacked Column)
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.stretch, // Makes buttons full width
              children: [
                _buildActionButton(
                  context,
                  label: "Update Prospek",
                  color: Colors.green,
                  onPressed: () {
                    context.push(
                      AppRoutePaths.batalaktivitas,
                    );
                  },
                ),
                const SizedBox(height: 10),
                _buildActionButton(
                  context,
                  label: "Buat Aktivitas",
                  color: Colors.blue.shade500,
                  onPressed: () {
                    _showStartConfirmationDialog(context);
                  },
                ),
              ],
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

  Widget _buildActionButton(BuildContext context,
      {required String label,
      required Color color,
      required VoidCallback? onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed, // Null makes button disabled
      child: Text(label, style: const TextStyle(fontSize: 14)),
    );
  }
}

// ✅ Tambahkan fungsi modal konfirmasi
void _showStartConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Apakah kamu yakin ingin memulai aktivitas?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Tutup modal
            },
            child: const Text("Tidak",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.push(
                AppRoutePaths.perkembanganaktivitas,
              );
            },
            child: const Text("Ya",
                style: TextStyle(
                    color: Colors.green, fontWeight: FontWeight.bold)),
          ),
        ],
      );
    },
  );
}
