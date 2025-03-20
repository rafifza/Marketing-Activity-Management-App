import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mam/core/colors/app_color.dart';
import 'package:mam/core/fonts/font_size.dart';
import 'package:mam/core/widgets/custom_textfield.dart';
import 'package:mam/feature/buataktivitas/model/buat_aktivitas_controller.dart';
import 'package:mam/feature/buataktivitas/model/buat_aktivitas_model.dart';

class CustomDropdownSearchKlien extends StatefulWidget {
  final String hint;
  final ValueNotifier<String?> controller;
  final BuatAktivitasController aktivitasController;
  final String selectedTipeKlien;
  final String selectedJenis;

  const CustomDropdownSearchKlien({
    super.key,
    required this.hint,
    required this.controller,
    required this.aktivitasController,
    required this.selectedTipeKlien,
    required this.selectedJenis,
  });

  @override
  State<CustomDropdownSearchKlien> createState() =>
      _CustomDropdownSearchKlienState();
}

class _CustomDropdownSearchKlienState extends State<CustomDropdownSearchKlien> {
  late TextEditingController searchController;
  late List<String> filteredItems;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();

    // Set initial value if available
    if (widget.controller.value != null) {
      _updateTextFields(widget.controller.value);
    }
  }

  void _updateTextFields(String? value) {
    if (value == null) return;

    final selectedKlien = widget.aktivitasController.klienList.firstWhere(
      (klien) => klien.nama == value,
      orElse: () => Klien(
        nama: '',
        alamat: '',
        kota: '',
        notelp: '',
        email: '',
      ),
    );

    widget.aktivitasController.klienAlamatController.text =
        selectedKlien.alamat;
    widget.aktivitasController.klienKotaController.text = selectedKlien.kota;
    widget.aktivitasController.klienNotelpController.text =
        selectedKlien.notelp;
    widget.aktivitasController.klienEmailController.text = selectedKlien.email;
  }

  Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    bool isDisabled = widget.selectedTipeKlien == "Klien Baru" ||
        widget.selectedTipeKlien == "Klien Terdaftar";
    bool isShow = widget.selectedTipeKlien.isNotEmpty;

    return Column(
      children: [
        DropdownButtonFormField2<String>(
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            decoration: BoxDecoration(
              color: AppColor.backgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          hint: Text(
            widget.hint,
            style: const TextStyle(fontSize: FontSize.bodyText),
          ),
          items: widget.aktivitasController.klienList.map((Klien klien) {
            return DropdownMenuItem<String>(
              value: klien.nama,
              child: Text(klien.nama),
            );
          }).toList(),
          value: widget.controller.value,
          onChanged: (value) {
            setState(() {
              widget.controller.value = value;
              _updateTextFields(value);
            });
          },
          dropdownSearchData: DropdownSearchData(
            searchController: searchController,
            searchInnerWidgetHeight: 50,
            searchInnerWidget: Padding(
              padding: const EdgeInsets.all(8),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (isShow) const SizedBox(height: 20),
        if (isShow)
          CustomTextField(
            controller: widget.aktivitasController.klienAlamatController,
            label: 'Alamat Klien',
            keyboardType: TextInputType.text,
            disabled: isDisabled,
          ),
        if (isShow) const SizedBox(height: 20),
        if (isShow)
          CustomTextField(
            controller: widget.aktivitasController.klienKotaController,
            label: 'Kota Klien',
            keyboardType: TextInputType.text,
            disabled: isDisabled,
          ),
        if (isShow) const SizedBox(height: 20),
        if (isShow)
          CustomTextField(
            controller: widget.aktivitasController.klienNotelpController,
            label: 'No Telp Klien',
            keyboardType: TextInputType.text,
            disabled: isDisabled,
          ),
        if (isShow) const SizedBox(height: 20),
        if (isShow)
          CustomTextField(
            controller: widget.aktivitasController.klienEmailController,
            label: 'Email Klien',
            keyboardType: TextInputType.text,
            disabled: isDisabled,
          ),
      ],
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
