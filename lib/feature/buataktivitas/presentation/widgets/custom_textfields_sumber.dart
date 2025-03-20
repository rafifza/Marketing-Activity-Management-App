import 'package:flutter/material.dart';
import 'package:mam/core/widgets/custom_textfield.dart';
import 'package:mam/feature/buataktivitas/model/buat_aktivitas_controller.dart';

class CustomTextfieldSumber extends StatelessWidget {
  final BuatAktivitasController aktivitasController;

  const CustomTextfieldSumber({
    super.key,
    required this.aktivitasController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: aktivitasController.sumberNamaController,
          label: 'Nama Sumber',
          keyboardType: TextInputType.text,
          disabled: false, // Bisa diisi bebas
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: aktivitasController.sumberAlamatController,
          label: 'Alamat Sumber',
          keyboardType: TextInputType.text,
          disabled: false,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: aktivitasController.sumberKotaController,
          label: 'Kota Sumber',
          keyboardType: TextInputType.text,
          disabled: false,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: aktivitasController.sumberPicController,
          label: 'PIC Sumber',
          keyboardType: TextInputType.text,
          disabled: false,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: aktivitasController.sumberJabatanController,
          label: 'Jabatan Sumber',
          keyboardType: TextInputType.text,
          disabled: false,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: aktivitasController.sumberNotelpController,
          label: 'No Telp Sumber',
          keyboardType: TextInputType.text,
          disabled: false,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
