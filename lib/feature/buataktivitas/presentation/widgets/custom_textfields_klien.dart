import 'package:flutter/material.dart';
import 'package:mam/core/widgets/custom_textfield.dart';
import 'package:mam/feature/buataktivitas/model/buat_aktivitas_controller.dart';

class CustomTextfieldsKlien extends StatelessWidget {
  final BuatAktivitasController aktivitasController;

  const CustomTextfieldsKlien({
    super.key,
    required this.aktivitasController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          controller: aktivitasController.klienNamaController,
          label: 'Nama Klien',
          keyboardType: TextInputType.text,
          disabled: false, // Bisa diisi bebas
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: aktivitasController.klienAlamatController,
          label: 'Alamat Klien',
          keyboardType: TextInputType.text,
          disabled: false,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: aktivitasController.klienKotaController,
          label: 'Kota Klien',
          keyboardType: TextInputType.text,
          disabled: false,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: aktivitasController.klienNotelpController,
          label: 'No Telp Klien',
          keyboardType: TextInputType.text,
          disabled: false,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          controller: aktivitasController.klienEmailController,
          label: 'Email Klien',
          keyboardType: TextInputType.text,
          disabled: false,
        ),
      ],
    );
  }
}
