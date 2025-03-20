import 'package:flutter/material.dart';

class AktivitasModel {
  final String waktu;
  final String agenda;
  final String jenis;
  final String sumberBisnis;
  final String tipeKlien;
  final DateTime date;
  final TimeOfDay time;
  final String alamat;
  final String jenisAktivitas;
  final String namaSumber;
  final String alamatSumber;
  final String kotaSumber;
  final String picSumber;
  final String jabatanSumber;
  final String notelpSumber;
  final String namaKlien;
  final String alamatKlien;
  final String kotaKlien;
  final String notelpKlien;

  AktivitasModel({
    required this.waktu,
    required this.agenda,
    required this.jenis,
    required this.sumberBisnis,
    required this.tipeKlien,
    required this.date,
    required this.time,
    required this.alamat,
    required this.jenisAktivitas,
    required this.namaSumber,
    required this.alamatSumber,
    required this.kotaSumber,
    required this.picSumber,
    required this.jabatanSumber,
    required this.notelpSumber,
    required this.namaKlien,
    required this.alamatKlien,
    required this.kotaKlien,
    required this.notelpKlien,
  });
}

class Sumber {
  final String nama;
  final String alamat;
  final String kota;
  final String pic;
  final String jabatan;
  final String notelp;

  Sumber({
    required this.nama,
    required this.alamat,
    required this.kota,
    required this.pic,
    required this.jabatan,
    required this.notelp,
  });
}

class Klien {
  final String nama;
  final String alamat;
  final String kota;
  final String notelp;
  final String email;

  Klien(
      {required this.nama,
      required this.alamat,
      required this.kota,
      required this.notelp,
      required this.email});
}
