import 'package:day_night_time_picker/lib/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mam/core/routes/app_route.dart';
import 'package:mam/feature/dashboard/model/aktivitas_base_model.dart';

class PerkembanganAktivitas extends StatelessWidget {
  final AktivitasBase aktivitas;

  const PerkembanganAktivitas({
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
      appBar: AppBar(title: const Text('Perkembangan Aktivitas')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      0: FixedColumnWidth(130),
                      1: FixedColumnWidth(10),
                      2: FlexColumnWidth(),
                    },
                    children: [
                      _buildTableRow(
                          'Jam mulai', TimeOfDay.now().format(context)),
                      _buildTableRow('Jam selesai', ''),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Card for Image & Signature
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Perkembangan Aktivitas",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Table(
                        columnWidths: const {
                          0: FixedColumnWidth(130),
                          1: FixedColumnWidth(10),
                          2: FlexColumnWidth(),
                        },
                        children: [
                          TableRow(
                            children: [
                              const Text("Perkembangan"),
                              const Text(":"),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Text(''),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Text("Kategori Polis"),
                              const Text(":"),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Text(''),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Text("Jenis Asurasi"),
                              const Text(":"),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Text(''),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Text("Obyek Asuransi"),
                              const Text(":"),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Text(''),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Text("TSI"),
                              const Text(":"),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Text(''),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Text("Estimasi Premi"),
                              const Text(":"),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Text(''),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              const Text("Catatan"),
                              const Text(":"),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Text(''),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Buttons Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildActionButton(
                    context,
                    label: "Simpan Perkembangan",
                    color: Colors.green, // Success/Completion
                    onPressed: () {
                      _showStartConfirmationDialog(context, aktivitas);
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildActionButton(
                    context,
                    label: "Ubah Perkembangan",
                    color: Colors.orange, // Camera/Capture Action
                    onPressed: () {
                      context.push(AppRoutePaths.ubahperkembangan,
                          extra: aktivitas);
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              )
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
          borderRadius: BorderRadius.circular(20),
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
        content: const Text(
            "Apakah kamu yakin bahwa perkembangan yang kamu isi sudah sesuai?"),
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
              context.push(AppRoutePaths.buktiaktivitas, extra: aktivitas);
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
