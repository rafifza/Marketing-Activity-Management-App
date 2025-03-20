import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mam/core/routes/app_route.dart';
import 'package:mam/feature/dashboard/model/aktivitas_base_model.dart';

class DetailAktivitas extends StatelessWidget {
  final AktivitasBase aktivitas;

  const DetailAktivitas({
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

    bool isFutureDate = aktivitasOnly.isAfter(todayOnly);
    bool isPastDate = aktivitasOnly.isBefore(todayOnly);

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Aktivitas')),
      body: SingleChildScrollView(
        child: Padding(
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
                      _buildTableRow('Agenda', aktivitas.title),
                      _buildTableRow('Jenis', aktivitas.description),
                      _buildTableRow('Sumber Bisnis', aktivitas.description),
                      _buildTableRow('Nama', aktivitas.description),
                      _buildTableRow(
                          'Tanggal', aktivitas.date.toLocal().toString()),
                      _buildTableRow(
                          'Jam', aktivitas.date.toLocal().toString()),
                      _buildTableRow('Alamat', aktivitas.location),
                      _buildTableRow('Notelp', aktivitas.organizer),
                      _buildTableRow('PIC', (aktivitas.time)),
                      _buildTableRow('Catatan', (aktivitas.time)),
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
                    label: "Mulai",
                    color: Colors.green,
                    onPressed: isFutureDate || isPastDate
                        ? null
                        : () {
                            _showStartConfirmationDialog(context, aktivitas);
                          },
                  ),
                  const SizedBox(height: 10),
                  _buildActionButton(
                    context,
                    label: "Reschedule",
                    color: Colors.blue,
                    onPressed: isPastDate
                        ? null
                        : () {
                            context.push(AppRoutePaths.rescheduleaktivitas,
                                extra: aktivitas);
                          },
                  ),
                  const SizedBox(height: 10),
                  _buildActionButton(
                    context,
                    label: "Batalkan",
                    color: Colors.red,
                    onPressed: isPastDate
                        ? null
                        : () {
                            context.push(AppRoutePaths.batalaktivitas,
                                extra: aktivitas);
                          },
                  ),
                ],
              ),
            ],
          ),
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
void _showStartConfirmationDialog(
    BuildContext context, AktivitasBase aktivitas) {
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
                extra: aktivitas,
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
