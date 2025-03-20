import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:mam/core/colors/app_color.dart';
import 'package:mam/core/widgets/custom_dropdown.dart';
import 'package:mam/core/widgets/custom_textfield.dart';
import 'package:mam/feature/calculator/model/calculator_controller.dart';
import 'package:mam/feature/calculator/model/input_formatter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class PropertiesForm extends StatefulWidget {
  const PropertiesForm({super.key});

  @override
  State<PropertiesForm> createState() => _PropertiesFormState();
}

class _PropertiesFormState extends State<PropertiesForm> {
  final CalculatorController _controller = CalculatorController();

  // Periode Asuransi
  String selectedOption = 'Periode'; // Default to Periode
  DateTime? startDate;
  DateTime? endDate;

  // Result variables
  double? nilaiBawah;
  double? nilaiAtas;
  double? nilaiBiayaPolis;

  // Checkbox states
  bool isFloodWindstorm = false;
  bool isSRCC = false;
  bool isEQVET = false;
  bool isTS = false;

  void _calculateResult() {
    double nilaiPertanggungan =
        double.tryParse(_controller.nilaiPertanggunganController.text) ?? 0;

    setState(() {
      nilaiBawah = nilaiPertanggungan * 0.8;
      nilaiAtas = nilaiPertanggungan * 1.2;
      nilaiBiayaPolis = nilaiPertanggungan * 0.02;
    });
  }

  void _onDateRangeChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      setState(() {
        startDate = args.value.startDate;
        endDate = args.value.endDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Periode Asuransi Selection
              const Text(
                'Periode Asuransi',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Radio(
                    value: 'Periode',
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value as String;
                      });
                    },
                  ),
                  const Text('Periode'),
                  const SizedBox(width: 20),
                  Radio(
                    value: 'Tahun',
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value as String;
                      });
                    },
                  ),
                  const Text('Tahun'),
                ],
              ),

              if (selectedOption == 'Periode') ...[
                SfDateRangePicker(
                  selectionMode: DateRangePickerSelectionMode.range,
                  initialSelectedRange: PickerDateRange(startDate, endDate),
                  minDate: DateTime(2000),
                  maxDate: DateTime(2100),
                  onSelectionChanged: _onDateRangeChanged,
                  backgroundColor: AppColor.cardColor,
                  todayHighlightColor: AppColor.gradient1,
                  selectionColor: AppColor.gradient1,
                  rangeSelectionColor: AppColor.backgroundColor,
                ),
              ] else ...[
                CustomTextField(
                  controller: _controller.tahunController,
                  keyboardType: TextInputType.number,
                  label: 'Lama Asuransi (Tahun)',
                ),
              ],
              const SizedBox(height: 10),

              DropdownButton2<String>(
                isExpanded: true,
                hint: const Text(
                  'Pilih Okupasi',
                  style: TextStyle(fontSize: 16),
                ),
                items: _controller.filteredOkupasiList.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
                value: _controller.okupasi,
                onChanged: (value) {
                  setState(() {
                    _controller.okupasi = value;
                  });
                },
                buttonStyleData: ButtonStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200, // Sesuai dengan DropdownButtonFormField2
                  decoration: BoxDecoration(
                    color: AppColor.backgroundColor, // Sesuaikan dengan tema
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                dropdownSearchData: DropdownSearchData(
                  searchController: _controller.okupasiSearchController,
                  searchInnerWidgetHeight: 50,
                  searchInnerWidget: Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      controller: _controller.okupasiSearchController,
                      decoration: InputDecoration(
                        hintText: 'Cari...',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (query) {
                        setState(() {
                          _controller.filterOkupasi(query);
                        });
                      },
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return item.value!
                        .toLowerCase()
                        .contains(searchValue.toLowerCase());
                  },
                ),
              ),

              const SizedBox(height: 10),

              CustomDropdown(
                hint: 'Kelas Kontruksi',
                items: _controller.kelasKontruksiList,
                value: _controller.kelasKontruksi,
                onChanged: (value) {
                  setState(() {
                    _controller.kelasKontruksi = value;
                  });
                },
              ),
              const SizedBox(height: 10),

              CustomTextField(
                controller: _controller.nilaiPertanggunganController,
                keyboardType: TextInputType.number,
                label: 'Nilai Pertanggungan',
                inputFormatters: [CurrencyInputFormatter()],
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _calculateResult,
                  child: const Text('Hitung'),
                ),
              ),
              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Hasil Perhitungan:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Nilai Bawah: Rp $nilaiBawah'),
                    Text('Nilai Atas: Rp $nilaiAtas'),
                    Text('Nilai Biaya Polis: Rp $nilaiBiayaPolis'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
