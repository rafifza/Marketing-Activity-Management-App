import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mam/core/routes/app_route.dart';
import 'package:mam/core/widgets/custom_textfield.dart';
import 'package:mam/feature/dashboard/model/aktivitas_base_model.dart';

class UbahPerkembangan extends StatefulWidget {
  final AktivitasBase aktivitas;

  const UbahPerkembangan({super.key, required this.aktivitas});

  @override
  UbahPerkembanganState createState() => UbahPerkembanganState();
}

class UbahPerkembanganState extends State<UbahPerkembangan> {
  final TextEditingController perkembanganController = TextEditingController();
  final TextEditingController kategoriPolisController = TextEditingController();
  final TextEditingController jenisAsuransiController = TextEditingController();
  final TextEditingController obyekAsuransiController = TextEditingController();
  final TextEditingController tsiController = TextEditingController();
  final TextEditingController estimasiPremiController = TextEditingController();
  final TextEditingController catatanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ubah Perkembangan')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextField("Perkembangan", perkembanganController),
            _buildTextField("Kategori Polis", kategoriPolisController),
            _buildTextField("Jenis Asuransi", jenisAsuransiController),
            _buildTextField("Obyek Asuransi", obyekAsuransiController),
            _buildTextField("TSI", tsiController),
            _buildTextField("Estimasi Premi", estimasiPremiController),
            _buildTextField("Catatan", catatanController),
            const SizedBox(height: 20),
            _buildActionButton(
              context,
              label: "Simpan Perkembangan",
              color: Colors.green,
              onPressed: () {
                _showStartConfirmationDialog(context);
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CustomTextField(
        controller: controller,
        label: label,
      ),
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
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(fontSize: 14)),
    );
  }

  void _showStartConfirmationDialog(BuildContext context) {
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
                Navigator.of(context).pop();
              },
              child: const Text("Tidak",
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.push(AppRoutePaths.buktiaktivitas,
                    extra: widget.aktivitas);
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
}
