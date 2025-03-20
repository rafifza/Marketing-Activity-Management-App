import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mam/core/colors/app_color.dart';
import 'package:mam/core/fonts/font_size.dart';
import 'package:mam/core/widgets/custom_textfield.dart';
import 'package:mam/feature/buataktivitas/model/buat_aktivitas_controller.dart';
import 'package:mam/feature/buataktivitas/model/buat_aktivitas_model.dart';

class CustomDropdownSearchSumber extends StatefulWidget {
  final String hint;
  final ValueNotifier<String?> controller;
  final BuatAktivitasController aktivitasController;
  final String selectedTipeKlien;
  final String selectedJenis;

  const CustomDropdownSearchSumber({
    super.key,
    required this.hint,
    required this.controller,
    required this.aktivitasController,
    required this.selectedTipeKlien,
    required this.selectedJenis,
  });

  @override
  State<CustomDropdownSearchSumber> createState() =>
      _CustomDropdownSearchSumberState();
}

class _CustomDropdownSearchSumberState
    extends State<CustomDropdownSearchSumber> {
  late TextEditingController searchController;
  late List<String> filteredItems;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();

    // Set initial value if available
    if (widget.controller.value != null) {
      _updateTextFields(widget.controller.value);

      // Log the selectedJenis when the widget is initialized
      logger.d("Initial selectedJenis: ${widget.selectedJenis}");

      // Set initial value if available
      if (widget.controller.value != null) {
        _updateTextFields(widget.controller.value);
      }
    }
  }

  void _updateTextFields(String? value) {
    if (value == null) return;

    final selectedSumber = widget.aktivitasController.sumberrList.firstWhere(
      (sumber) => sumber.nama == value,
      orElse: () => Sumber(
        nama: '',
        alamat: '',
        kota: '',
        pic: '',
        jabatan: '',
        notelp: '',
      ),
    );

    widget.aktivitasController.sumberAlamatController.text =
        selectedSumber.alamat;
    widget.aktivitasController.sumberKotaController.text = selectedSumber.kota;
    widget.aktivitasController.sumberPicController.text = selectedSumber.pic;
    widget.aktivitasController.sumberJabatanController.text =
        selectedSumber.jabatan;
    widget.aktivitasController.sumberNotelpController.text =
        selectedSumber.notelp;
  }

  Logger logger = Logger();
  @override
  Widget build(BuildContext context) {
    // Log selectedJenis on every build
    logger.d("Building widget, selectedJenis: ${widget.selectedJenis}");
    bool isDisabled = widget.selectedTipeKlien == "Klien Baru" ||
        widget.selectedTipeKlien == "Klien Terdaftar";
    bool isShow = widget.selectedTipeKlien.isNotEmpty;

    return Column(
      children: [
        if (widget.selectedTipeKlien == "Klien Baru" ||
            widget.selectedTipeKlien == "Klien Terdaftar")
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
            items: widget.aktivitasController.sumberrList.map((Sumber sumber) {
              return DropdownMenuItem<String>(
                value: sumber.nama,
                child: Text(sumber.nama),
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
        if (widget.selectedTipeKlien == "Sumber & Klien Baru")
          CustomTextField(
            controller: widget.aktivitasController.sumberNamaController,
            label: 'Nama Sumber',
            keyboardType: TextInputType.text,
          ),
        if (isShow) const SizedBox(height: 20),
        if (isShow)
          CustomTextField(
            controller: widget.aktivitasController.sumberAlamatController,
            label: 'Alamat Sumber',
            keyboardType: TextInputType.text,
            disabled: isDisabled,
          ),
        if (isShow) const SizedBox(height: 20),
        if (isShow)
          CustomTextField(
            controller: widget.aktivitasController.sumberKotaController,
            label: 'Kota Sumber',
            keyboardType: TextInputType.text,
            disabled: isDisabled,
          ),
        if (isShow) const SizedBox(height: 20),
        if (isShow)
          CustomTextField(
            controller: widget.aktivitasController.sumberPicController,
            label: 'PIC Sumber',
            keyboardType: TextInputType.text,
            disabled: true,
          ),
        if (isShow) const SizedBox(height: 20),
        if (isShow)
          CustomTextField(
            controller: widget.aktivitasController.sumberJabatanController,
            label: 'Jabatan Sumber',
            keyboardType: TextInputType.text,
            disabled: isDisabled,
          ),
        if (isShow) const SizedBox(height: 20),
        if (isShow)
          CustomTextField(
            controller: widget.aktivitasController.sumberNotelpController,
            label: 'No telp Sumber',
            keyboardType: TextInputType.text,
            disabled: isDisabled,
          ),
        if (isShow) const SizedBox(height: 20),
      ],
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
