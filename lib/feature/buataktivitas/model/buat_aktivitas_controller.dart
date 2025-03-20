import 'package:flutter/material.dart';
import 'package:mam/feature/buataktivitas/model/buat_aktivitas_model.dart';

class BuatAktivitasController {
  // Agenda Controller
  final ValueNotifier<String?> agendaController = ValueNotifier<String?>(null);
  String selectedAgenda = '';
  List<String> agendaList = ['Prospek', 'Maintenance'];

  // Jenis Controller
  final ValueNotifier<String?> jenisController = ValueNotifier<String?>(null);
  String selectedJenis = '';
  List<String> jenisList = ['Langsung', 'Pihak ke III'];

  // Pilih Sumber Bisnis Controller
  final ValueNotifier<List<String>> sumberBisnisListNotifier =
      ValueNotifier<List<String>>([]);
  final ValueNotifier<String?> sumberBisnisController =
      ValueNotifier<String?>(null);
  String selectedSumberBisnis = '';
  List<String> sumberBisnisList = [];

  // Function to update the sumberBisnisList based on the selected jenis
  void updateSumberBisnisList() {
    List<String> updatedList = [];

    if (selectedJenis == 'Langsung') {
      updatedList = ['Non Institusi', 'Institusi', 'Referral'];
    } else if (selectedJenis == 'Pihak ke III') {
      updatedList = [
        'BNI',
        'Bank Lain',
        'CoInsurance',
        'Leasing',
        'Broker',
        'Agent'
      ];
    }
    // Update the notifier value to trigger UI changes
    sumberBisnisListNotifier.value = updatedList;

    // Reset the selectedSumberBisnis and the ValueNotifier
    selectedSumberBisnis = '';
    sumberBisnisController.value = null;
  }

  // Tipe Klien Controller
  final ValueNotifier<List<String>> tipeKlienListNotifier =
      ValueNotifier<List<String>>([]);
  final ValueNotifier<String?> tipeKlienController =
      ValueNotifier<String?>(null);
  String selectedTipeKlien = '';
  List<String> tipeKlienList = [
    'Klien Terdaftar',
    'Klien Baru',
    'Sumber & Klien Baru'
  ];

  // Function to update tipeKlienList based on selected jenis
  void updateTipeKlienList() {
    List<String> updatedList = [];

    if (selectedJenis == 'Langsung') {
      updatedList = ['Klien Terdaftar', 'Klien Baru'];
    } else if (selectedJenis == 'Pihak ke III') {
      updatedList = tipeKlienList; // Show all options
    }

    // Update the notifier
    tipeKlienListNotifier.value = updatedList;
    selectedTipeKlien = '';
    tipeKlienController.value = null;
  }

  // Date Controller
  final TextEditingController dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  // Time Controller
  final TextEditingController timeController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();
  TimeOfDay get selectedTime => _selectedTime;
  set selectedTime(TimeOfDay time) {
    _selectedTime = time;
    timeController.text =
        '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
  }

  // Alamat Controller
  final TextEditingController alamatController = TextEditingController();

  // Jenis Aktivitas Controller
  final ValueNotifier<String?> jenisAktivitasController =
      ValueNotifier<String?>(null);
  String selectedJenisAktivitas = '';
  List<String> jenisAktivitasList = [
    'Pertemuan',
    'Rekonsiliasi',
    'Kunjungan rutin',
    'Tindak lanjut',
    'Renewal notice',
    'Penyerahan polis',
    'Penagihan premi',
    'Administrasi',
    'Zoom internal cabang',
    'On call',
  ];

// Sumber Bisnis Controller
  final ValueNotifier<String?> sumberController = ValueNotifier<String?>(null);
  final TextEditingController sumberNamaController = TextEditingController();

// Sumber Alamat Controller
  final TextEditingController sumberAlamatController = TextEditingController();

// Sumber Kota Controller
  final TextEditingController sumberKotaController = TextEditingController();

// Sumber PIC Controller
  final TextEditingController sumberPicController = TextEditingController();

// Sumber Jabatan Controller
  final TextEditingController sumberJabatanController = TextEditingController();

// Sumber Notelp Controller
  final TextEditingController sumberNotelpController = TextEditingController();

//Klien Nama Controller
  final ValueNotifier<String?> klienController = ValueNotifier<String?>(null);
  final TextEditingController klienNamaController = TextEditingController();

//Klien Alamat Controller
  final TextEditingController klienAlamatController = TextEditingController();

//Klien Kota Controller
  final TextEditingController klienKotaController = TextEditingController();

//Klien Notelp Controller
  final TextEditingController klienNotelpController = TextEditingController();

//Klien Email Controller
  final TextEditingController klienEmailController = TextEditingController();

// Dummy Data
  List<Sumber> sumberrList = [
    Sumber(
      nama: "PT. ABC",
      alamat: "Jl. Sudirman No.10",
      kota: "Jakarta",
      pic: "Budi Santoso",
      jabatan: "Manager",
      notelp: "08123456789",
    ),
    Sumber(
      nama: "CV. XYZ",
      alamat: "Jl. Merdeka No.5",
      kota: "Bandung",
      pic: "Andi Wijaya",
      jabatan: "Direktur",
      notelp: "08129876543",
    ),
    Sumber(
      nama: "UD. Maju Jaya",
      alamat: "Jl. Diponegoro No.20",
      kota: "Surabaya",
      pic: "Siti Rahma",
      jabatan: "Supervisor",
      notelp: "08134567890",
    ),
  ];

  // Dummy Data
  List<Klien> klienList = [
    Klien(
      nama: "PT. XXX",
      alamat: "Jl. Sudirman No.10",
      kota: "Jakarta",
      notelp: "08123456789",
      email: "contact@ptabc.com",
    ),
    Klien(
      nama: "CV. XYZ",
      alamat: "Jl. Merdeka No.5",
      kota: "Bandung",
      notelp: "08129876543",
      email: "info@cvxyz.com",
    ),
    Klien(
      nama: "UD. Maju Jaya",
      alamat: "Jl. Diponegoro No.20",
      kota: "Surabaya",
      notelp: "08134567890",
      email: "support@majujaya.com",
    ),
  ];

  Future<bool> sendAktivitas({
    required String agenda,
    required String jenis,
    required String sumberbisnis,
    required String tipeKlien,
    required DateTime date,
    required TimeOfDay time,
    required String alamat,
    required String jenisAktivitas,
    required String sumberNama,
    required String sumberAlamat,
    required String sumberKota,
    required String sumberPic,
    required String sumberJabatan,
    required String sumberNotelp,
    required String klienNama,
    required String klienAlamat,
    required String klienKota,
    required String klienNotelp,
    required String klienEmail,
  }) async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    return true; // Assume success
  }
}
