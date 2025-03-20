class Vehicle {
  final String jenisKendaraan;
  final String areaPenggunaan;
  final int tahunKendaraan;
  final int nilaiPertanggungan;
  final DateTime periodeAsuransiTanggal;
  final int periodeAsuransiTahun;
  final String cover;
  final String tjh;
  final String paDriver;
  final String paPassanger;

  Vehicle({
    required this.jenisKendaraan,
    required this.areaPenggunaan,
    required this.tahunKendaraan,
    required this.nilaiPertanggungan,
    required this.periodeAsuransiTanggal,
    required this.periodeAsuransiTahun,
    required this.cover,
    required this.tjh,
    required this.paDriver,
    required this.paPassanger,
  });
}

class Property {
  final String jenisProperti;
  final String areaPenggunaan;
  final int tahunProperti;
  final int nilaiPertanggungan;
  final DateTime periodeAsuransiTanggal;
  final int periodeAsuransiTahun;
  final String cover;
  final String tjh;
  final String paDriver;
  final String paPassanger;

  Property({
    required this.jenisProperti,
    required this.areaPenggunaan,
    required this.tahunProperti,
    required this.nilaiPertanggungan,
    required this.periodeAsuransiTanggal,
    required this.periodeAsuransiTahun,
    required this.cover,
    required this.tjh,
    required this.paDriver,
    required this.paPassanger,
  });
}
