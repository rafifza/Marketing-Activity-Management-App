import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:mam/feature/dashboard/model/aktivitas_base_model.dart';

class RescheduleAktivitas extends StatefulWidget {
  final AktivitasBase aktivitas;

  const RescheduleAktivitas({super.key, required this.aktivitas});

  @override
  RescheduleAktivitasState createState() => RescheduleAktivitasState();
}

class RescheduleAktivitasState extends State<RescheduleAktivitas> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final TextEditingController noteController = TextEditingController();

  void _selectDate(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Pilih Tanggal"),
          content: SizedBox(
            height: 300,
            child: SfDateRangePicker(
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                if (args.value is DateTime) {
                  setState(() {
                    selectedDate = args.value;
                  });
                  Navigator.of(ctx).pop(); // Close dialog
                }
              },
              selectionMode: DateRangePickerSelectionMode.single,
            ),
          ),
        );
      },
    );
  }

  // void _selectTime(BuildContext context) {
  //   Navigator.of(context).push(
  //     showPicker(
  //       context: context,
  //       value: selectedTime,
  //       onChange: (TimeOfDay newTime) {
  //         setState(() {
  //           selectedTime = newTime;
  //         });
  //       },
  //       is24HrFormat: true, // 24-hour format
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pembatalan Aktivitas')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    0: FixedColumnWidth(100), // Set a fixed width for labels
                    1: FixedColumnWidth(10), // Small space for the colon
                    2: FlexColumnWidth(), // Value takes remaining space
                  },
                  children: [
                    _buildTableRow('Title', widget.aktivitas.title),
                    _buildTableRow('Description', widget.aktivitas.description),
                    _buildTableRow(
                        'Date', widget.aktivitas.date.toLocal().toString()),
                    _buildTableRow('Location', widget.aktivitas.location),
                    _buildTableRow('Organizer', widget.aktivitas.organizer),
                    _buildTableRow('Completed', (widget.aktivitas.time)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Date Picker Button
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate != null
                          ? "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}"
                          : "Pilih Tanggal",
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    const Icon(Icons.calendar_today, color: Colors.blue),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Time Picker Button
            // GestureDetector(
            //   onTap: () => _selectTime(context),
            //   child: Container(
            //     padding:
            //         const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            //     decoration: BoxDecoration(
            //       border: Border.all(color: Colors.grey),
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text(
            //           selectedTime != null
            //               ? "${selectedTime!.hour}:${selectedTime!.minute.toString().padLeft(2, '0')}"
            //               : "Pilih Waktu",
            //           style: TextStyle(fontSize: 16, color: Colors.black87),
            //         ),
            //         const Icon(Icons.access_time, color: Colors.blue),
            //       ],
            //     ),
            //   ),
            // ),

            const SizedBox(height: 20),

            // Cancellation Note Field
            TextField(
              controller: noteController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Alasan pembatalan",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Validate Inputs
                  if (selectedDate == null || selectedTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text("Harap pilih tanggal dan waktu pembatalan"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  // Handle cancellation submission
                  String cancellationReason = noteController.text.trim();
                  DateTime finalDateTime = DateTime(
                    selectedDate!.year,
                    selectedDate!.month,
                    selectedDate!.day,
                    selectedTime!.hour,
                    selectedTime!.minute,
                  );

                  print("Tanggal Pembatalan: $finalDateTime");
                  print("Alasan: $cancellationReason");

                  // TODO: Send data to API
                },
                child: const Text("Reschedule Aktivitas",
                    style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
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
}
