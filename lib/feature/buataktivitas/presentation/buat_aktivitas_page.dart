import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mam/core/colors/app_color.dart';
import 'package:mam/core/fonts/font_size.dart';
import 'package:mam/core/widgets/custom_dropdown.dart';
import 'package:mam/core/widgets/custom_textfield.dart';
import 'package:mam/feature/buataktivitas/model/buat_aktivitas_controller.dart';
import 'package:mam/feature/buataktivitas/presentation/widgets/custom_dropdown_klien.dart';
import 'package:mam/feature/buataktivitas/presentation/widgets/custom_dropdown_sumber.dart';
import 'package:mam/feature/buataktivitas/presentation/widgets/custom_textfields_klien.dart';
import 'package:mam/feature/buataktivitas/presentation/widgets/custom_textfields_sumber.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BuatAktivitasPage extends StatefulWidget {
  const BuatAktivitasPage({super.key});

  @override
  State<BuatAktivitasPage> createState() => _BuatAktivitasPageState();
}

class _BuatAktivitasPageState extends State<BuatAktivitasPage> {
  final BuatAktivitasController _controller = BuatAktivitasController();

  String? selectedAgenda;
  String? selectedJenis;
  String? selectedSumberBisnis;
  String? selectedTipeKlien;
  String? selectedJenisAktivitas;
  bool _isLoading = false;

  Future<void> _submitForm() async {
    if (!mounted) return;

    if (_controller.selectedAgenda.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih agenda terlebih dahulu!')),
      );
      return;
    }
    if (_controller.selectedJenis.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih jenis terlebih dahulu!')),
      );
      return;
    }
    if (_controller.selectedSumberBisnis.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih sumber bisnis terlebih dahulu!')),
      );
      return;
    }

    setState(() => _isLoading = true);

    bool result = await _controller.sendAktivitas(
      agenda: _controller.selectedAgenda,
      jenis: _controller.selectedJenis,
      sumberbisnis: _controller.selectedSumberBisnis,
      tipeKlien: _controller.selectedTipeKlien,
      date: _controller.selectedDate,
      time: _controller.selectedTime,
      alamat: _controller.alamatController.text,
      jenisAktivitas: _controller.selectedJenisAktivitas,
      sumberNama: _controller.sumberNamaController.text,
      sumberAlamat: _controller.sumberAlamatController.text,
      sumberKota: _controller.sumberKotaController.text,
      sumberPic: _controller.sumberPicController.text,
      sumberJabatan: _controller.sumberJabatanController.text,
      sumberNotelp: _controller.sumberNotelpController.text,
      klienNama: _controller.klienNamaController.text,
      klienAlamat: _controller.klienAlamatController.text,
      klienKota: _controller.klienKotaController.text,
      klienNotelp: _controller.klienNotelpController.text,
      klienEmail: _controller.klienEmailController.text,
    );

    if (!mounted) return;

    if (result) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Aktivitas berhasil dibuat!'),
          actions: [
            TextButton(
              onPressed: () {
                context.go('/home');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal membuat aktivitas.')),
      );
    }
    setState(() => _isLoading = false);
  }

  void onJenisChanged(String? value) {
    if (value != null) {
      setState(() {
        _controller.selectedJenis = value;
        _controller.updateSumberBisnisList();
        selectedJenis = value;
      });
    }
  }

  // Function to handle time selection using day_night_time_picker
  void pickTime(BuildContext context) {
    Navigator.of(context).push(
      showPicker(
        context: context,
        value: Time(
            hour: _controller.selectedTime.hour,
            minute: _controller.selectedTime.minute), // Konversi ke Time
        onChange: (newTime) {
          setState(() {
            _controller.selectedTime =
                TimeOfDay(hour: newTime.hour, minute: newTime.minute);
          });
        },
        is24HrFormat: true,
        iosStylePicker: true,
      ),
    );
  }

  // Function to handle date selection using SfDateRangePicker
  void pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SfDateRangePicker(
            minDate: DateTime.now(),
            onSelectionChanged: (args) {
              setState(() {
                _controller.selectedDate = args.value;
                _controller.dateController.text =
                    '${_controller.selectedDate.toLocal()}'.split(' ')[0];
              });
              Navigator.pop(context);
            },
            selectionMode: DateRangePickerSelectionMode.single,
            initialSelectedDate: _controller.selectedDate,
          ),
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        _controller.selectedDate = pickedDate;
        _controller.dateController.text =
            '${_controller.selectedDate.toLocal()}'.split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final Logger log = Logger();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text(
              'Buat Aktivitas',
              style: TextStyle(fontSize: FontSize.heading2),
            ),
            floating: true, // Disappear when scrolling down
            snap: true, // Reappear when scrolling up
            backgroundColor: AppColor.backgroundMiniNavbarIconInactive,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            pinned: false, // AppBar is not pinned
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomDropdown(
                          hint: 'Agenda',
                          items: _controller.agendaList,
                          value: selectedAgenda,
                          onChanged: (value) {
                            setState(() {
                              selectedAgenda = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomDropdown(
                          hint: 'Pilih Jenis',
                          items: _controller.jenisList,
                          value: (selectedJenis ?? '').isNotEmpty
                              ? selectedJenis
                              : null,
                          onChanged: (value) {
                            onJenisChanged(value);
                          },
                        ),

                        const SizedBox(height: 20),
                        ValueListenableBuilder<List<String>>(
                          valueListenable: _controller.sumberBisnisListNotifier,
                          builder: (context, sumberBisnisList, child) {
                            return ValueListenableBuilder<String?>(
                              valueListenable:
                                  _controller.sumberBisnisController,
                              builder: (context, selectedSumberBisnis, child) {
                                return CustomDropdown(
                                  hint: 'Pilih Sumber Bisnis',
                                  items: sumberBisnisList,
                                  value: selectedSumberBisnis,
                                  onChanged: (value) {
                                    _controller.sumberBisnisController.value =
                                        value; // ✅ Update ValueNotifier
                                  },
                                );
                              },
                            );
                          },
                        ),

                        const SizedBox(height: 20),
                        CustomDropdown(
                          hint: 'Pilih Tipe Klien',
                          items: _controller.selectedJenis == 'Langsung'
                              ? ['Klien Baru', 'Klien Terdaftar']
                              : _controller.tipeKlienList,
                          value: selectedTipeKlien,
                          onChanged: (value) {
                            setState(() {
                              selectedTipeKlien = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        // Date selection using SfDateRangePicker
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                12), // Add border radius here
                            border: Border.all(
                                color: Colors.grey), // Optional border
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                    const Offset(0, 3), // Adds shadow for depth
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                12), // Ensure SfDateRangePicker is clipped with the radius
                            child: SfDateRangePicker(
                              minDate: DateTime.now(),
                              onSelectionChanged:
                                  (DateRangePickerSelectionChangedArgs args) {
                                setState(() {
                                  _controller.selectedDate = args.value;
                                  _controller.dateController.text =
                                      '${_controller.selectedDate.toLocal()}'
                                          .split(' ')[0];
                                });
                              },
                              selectionMode:
                                  DateRangePickerSelectionMode.single,
                              initialSelectedDate: _controller.selectedDate,
                              backgroundColor: AppColor.backgroundColor,
                            ),
                          ),
                        ), // Time Picker with Day Night Picker
                        const SizedBox(height: 20),
                        TextField(
                          controller: _controller.timeController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 10),
                            label: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12), // Add left padding
                              child: Text('Pilih Waktu'),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  12), // Adjust the radius as needed
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Colors.grey), // Customize border color
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2), // Customize focus color
                            ),
                          ),
                          readOnly: true,
                          onTap: () => pickTime(context),
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          controller: _controller.alamatController,
                          label: 'Alamat',
                        ),
                        const SizedBox(height: 20),
                        CustomDropdown(
                          hint: 'Pilih Jenis Aktivitas',
                          items: _controller.jenisAktivitasList,
                          value: _controller.selectedJenisAktivitas.isEmpty
                              ? null
                              : _controller.selectedJenisAktivitas,
                          onChanged: (value) {
                            setState(() {
                              _controller.selectedJenisAktivitas = value ?? '';
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        Visibility(
                          visible: selectedJenis != "Langsung" &&
                              (selectedTipeKlien == "Klien Terdaftar" ||
                                  selectedTipeKlien == "Klien Baru"),
                          child: CustomDropdownSearchSumber(
                            hint: 'Nama Sumber',
                            controller: _controller.sumberController,
                            aktivitasController: BuatAktivitasController(),
                            selectedTipeKlien: selectedTipeKlien ?? "",
                            selectedJenis: selectedJenis ?? "",
                          ),
                        ),
                        Visibility(
                          visible: selectedJenis != "Langsung" &&
                              selectedTipeKlien == "Sumber & Klien Baru",
                          child: CustomTextfieldSumber(
                            aktivitasController: BuatAktivitasController(),
                          ),
                        ),
                        Visibility(
                          visible: selectedTipeKlien == "Klien Terdaftar",
                          child: CustomDropdownSearchKlien(
                            hint: 'Nama Klien',
                            controller: _controller.sumberController,
                            aktivitasController: BuatAktivitasController(),
                            selectedTipeKlien: selectedTipeKlien ?? "",
                            selectedJenis: selectedJenis ?? "",
                          ),
                        ),
                        Visibility(
                          visible: selectedTipeKlien == "Sumber & Klien Baru" ||
                              selectedTipeKlien == "Klien Baru",
                          child: CustomTextfieldsKlien(
                            aktivitasController: BuatAktivitasController(),
                          ),
                        ),
                        if (selectedTipeKlien != "") const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity, // Make button full width
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _submitForm,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // Rounded corners
                              ),
                              backgroundColor:
                                  AppColor.gradient2, // Use your theme color
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const Text(
                                    'Buat Aktivitas',
                                    style: TextStyle(
                                        fontSize: FontSize.bodyText,
                                        color: Colors.black),
                                  ),
                          ),
                        ),
                      ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
