import 'package:flutter/material.dart';
import 'package:mam/core/colors/app_color.dart';
import 'package:mam/core/widgets/custom_dropdown.dart';
import 'package:mam/core/widgets/custom_textfield.dart';
import 'package:mam/feature/calculator/model/calculator_controller.dart';
import 'package:mam/feature/calculator/model/input_formatter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class VehicleForm extends StatefulWidget {
  const VehicleForm({super.key});

  @override
  State<VehicleForm> createState() => _VehicleFormState();
}

class _VehicleFormState extends State<VehicleForm> {
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

              CustomDropdown(
                hint: 'Jenis Kendaraan',
                items: _controller.jenisKendaraanList,
                value: _controller.jenisKendaraan,
                onChanged: (value) {
                  setState(() {
                    _controller.jenisKendaraan = value;
                  });
                },
              ),
              const SizedBox(height: 10),

              CustomDropdown(
                hint: 'Area Penggunaan',
                items: _controller.areaPenggunaanList,
                value: _controller.areaPenggunaan,
                onChanged: (value) {
                  setState(() {
                    _controller.areaPenggunaan = value;
                  });
                },
              ),
              const SizedBox(height: 10),

              CustomTextField(
                controller: _controller.tahunKendaraanController,
                keyboardType: TextInputType.number,
                label: 'Tahun Kendaraan',
              ),
              const SizedBox(height: 10),

              CustomTextField(
                controller: _controller.nilaiPertanggunganController,
                keyboardType: TextInputType.number,
                label: 'Nilai Pertanggungan',
                inputFormatters: [CurrencyInputFormatter()],
              ),
              const SizedBox(height: 10),
              CustomDropdown(
                  hint: 'Cover',
                  items: _controller.coverList,
                  onChanged: (value) {
                    setState(() {
                      _controller.cover = value;
                    });
                  }),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _controller.tjhController,
                keyboardType: TextInputType.number,
                label: 'TJH',
                inputFormatters: [CurrencyInputFormatter()],
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _controller.paDriverController,
                keyboardType: TextInputType.number,
                label: 'PA Driver',
                inputFormatters: [CurrencyInputFormatter()],
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _controller.paPassangerController,
                keyboardType: TextInputType.number,
                label: 'PA Passenger',
                inputFormatters: [CurrencyInputFormatter()],
              ),
              const SizedBox(height: 10),
              // Optional Protection (2x2 Grid)
              const Text(
                'Tambahan Perlindungan:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  CheckboxListTile(
                    title: const Text('Flood & Windstorm',
                        style: TextStyle(fontSize: 12)),
                    value: isFloodWindstorm,
                    onChanged: (value) {
                      setState(() {
                        isFloodWindstorm = value!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('SRCC', style: TextStyle(fontSize: 12)),
                    value: isSRCC,
                    onChanged: (value) {
                      setState(() {
                        isSRCC = value!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('EQVET', style: TextStyle(fontSize: 12)),
                    value: isEQVET,
                    onChanged: (value) {
                      setState(() {
                        isEQVET = value!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('T&S', style: TextStyle(fontSize: 12)),
                    value: isTS,
                    onChanged: (value) {
                      setState(() {
                        isTS = value!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

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
