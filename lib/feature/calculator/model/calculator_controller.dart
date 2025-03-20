import 'package:flutter/material.dart';

class CalculatorController {
  // Jenis Kendaraan Controller
  ValueNotifier<String?> jenisKendaraanController =
      ValueNotifier<String?>(null);
  String? jenisKendaraan;
  List<String> jenisKendaraanList = [
    'Non Bus dan Non Truck',
    'Truck dan Pick Up',
    'Bus',
    'Roda Dua',
  ];

  // Area Penggunaan Controller
  ValueNotifier<String?> areaPenggunaanController =
      ValueNotifier<String?>(null);
  String? areaPenggunaan;
  List<String> areaPenggunaanList = [
    'Sumatera dan Kepulauannya',
    'Jakarta, Banten, dan Jawa Barat',
    'Selain tersebut diatas',
  ];

  // Tahun Kendaraan Controller
  final TextEditingController tahunKendaraanController =
      TextEditingController();

  // TahunController
  final TextEditingController tahunController = TextEditingController();

  // Nilai Pertanggungan Controller
  final TextEditingController nilaiPertanggunganController =
      TextEditingController();

  // Cover Controller
  ValueNotifier<String?> coverController = ValueNotifier<String?>(null);
  String? cover;
  List<String> coverList = [
    'Total Lost Only',
    'All Risk',
  ];

  // TJH Controller
  final TextEditingController tjhController = TextEditingController();

  // PA Driver Controller
  final TextEditingController paDriverController = TextEditingController();

  // PA Passanger Controller
  final TextEditingController paPassangerController = TextEditingController();

  // Okupasi Controller
  ValueNotifier<String?> okupasiController = ValueNotifier<String?>(null);
  String? okupasi;
  List<String> okupasiList = [
    '200 - Penambangan (bawah tanah atau di atas tanah) Logam mulia (emas, perak, platinum, dll.) termasuk terutama Peleburan dan pemurnian',
    '201 - Penambangan (bawah tanah atau di atas tanah) Aluminium termasuk terutama Peleburan dan kilang',
    '2020 - Tambang Besi (bawah tanah atau di atas tanah)',
    '2021 - Blast Furnaces and Iron Founddries, kegiatan pengubahan seperti reduksi biji besi dlm tungku pembakaran dan oxygen converter',
    '203 - Steelworks and rolling mills termasuk juga pembuatan besi dan baja paduan termasuk kegiatan tungku pembakaran selain Blast Furnaces, steel converter',
    '2051 - Ekstraksi dan Pemrosesan di atas Tanah',
    '2052 - Ekstraksi dan Pemrosesan di Bawah Tanah',
    '2058 - Lainnya dan/atau campuran',
    '206 - Pengecoran, Pabrik Reduksi (Peleburan dan Kilang) untuk Logam (Tidak Termasuk Besi, Alumunium dan logam mulia)',
    '2071 - Ekstraksi dan Pengolahan Batubara dan Lignit di atas Tanah (permukaan)',
    '2072 - Ekstraksi dan Pengolahan Batubara dan Lignit di Bawah Tanah',
    '2073 - Pabrik Kokas Batubara (kokas)',
    '2074 - Pembuatan Briket Batubara',
    '2081 - Tambang garam, ekstrasi dari batuan atau endapan yang menguap',
    '2082 - Ekstraksi garam (tambak Garam)',
    '209 - Ekstraksi gambut, pengolahan gambut',
    '210 - Instalasi ekstraksi batu, kerikil dan pasir',
    '21121 - Pabrik Semen dengan rotary kiln',
    '21122 - Pabrik Semen tanpa rotary kiln',
    '2113 - Produk beton, beton siap pakai, periuk yang tidak dibakar, industri beton, barang-barang dari batu buatan atau semen yang digunakan dalam konstruksi, seperti ubin, batu bata, papan, lembaran, panel, pipa, tonggak dan sebagainya.',
    '2114 - Gigi Buatan, Non Plastik',
    '2121 - Produk Asbes, potong Batu dan produk batu.',
    '2122 - Tulang hewan dan/atau penghancuran cangkang untuk pakan',
    '2123 - Wol mineral',
    '2131 - Pabrik yang hanya memiliki tempat pembakaran terowongan',
    '2132 - Pabrik yang lain Jenis Kiln',
    '2141 - Pabrik yang hanya memiliki tempat pembakaran terowongan',
    '2142 - Pabrik dengan tungku lain',
    '2151 - Wadah kaca, ditekan dan ditiup Kaca dan Barang Pecah Kaca',
    '2152 - Kaca Datar termasuk tempered',
    '2158 - Campuran',
    '216 - Produk Kaca Terbuat dari Kaca yang Dibeli, Lensa, kaca pengaman, cermin',
    '217 - Bengkel batu mulia dan pabrik pengolahan',
    '218 - Pabrik bahan ampelas dan abrasif',
    '2201 - Pabrik penggulungan lembaran dan pabrik pembuatan foil, pekerjaan tempa, tukang kunci, pekerjaan logam konstruksi, pipa isolasi atau logam',
    '2202 - Produk logam dari bubuk logam, industri penempaan, pengepresan, percetakan dan pembentukan logam dengan metalurgi bubuk',
    '2203 - Campuran',
    '22111 - Mesin Industri, pertambangan dan Komersial tanpa melelehkan logam',
    '22112 - Mesin Industri, pertambangan dan Komersial dengan logam peleburan',
    '2212 - Tanaman enamel dan seng',
    '2213 - Proses pelapisan menggunakan Bahan Mudah Terbakar termasuk pencelupan dan pengecatan semprot',
    '2214 - Pabrik furnitur logam/baja (di mana plastik dan busa digunakan), lemari plastik dan pabrik kursi lipat',
    '2215 - Pembuatan kasur pegas logam/baja (tanpa busa)',
    '2218 - Campuran',
    '2221 - Pembuatan perakitan dan perbaikan mesin dan peralatan listrik',
    '2222 - Pabrik akumulator dan baterai kering',
    '2223 - Pembuatan alat ukur, peralatan fotografi, instrumen presisi, dan laboratorium ilmiah',
    '2228 - Campuran',
    '2231 - Pabrik kawat',
    '2232 - Pabrik kabel',
    '2233 - Pabrik paku, sekrup, baut dan mur',
    '2238 - Campuran',
    '2241 - Pabrik konstruksi kendaraan termasuk sepeda dan becak (roda tiga)',
    '2242 - Konstruksi gerbong kereta api dan lokomotif',
    '2243 - Pabrik konstruksi pesawat',
    '2244 - Konstruksi kapal, galangan kapal angkatan laut',
    '2245 - Pabrik perakitan kendaraan',
    '2248 - Campuran',
    '2251 - Pembuatan dan atau perakitan peralatan telekomunikasi',
    '2252 - Pembuatan dan atau perakitan peralatan komputer',
    '2253 - Pembuatan Sirkuit Terpadu (IC) dari Chip',
    '2261 - Pabrik penerima radio dan televisi dan atau pabrik perakitan, pabrik perekam video audio dan atau pemutar dan atau pabrik perakitan',
    '2262 - Pabrik suku cadang untuk penerima radio dan televisi, perekam dan pemutar audio dan audio-video',
    '227 - Pabrik bola lampu, pembuatan tabung elektronik, dan tabung neon, tanda neon',
    '228 - Jam tangan dan jam serta pabrik suku cadang komponennya',
    '2299 - Industri lain dalam kategori utama 22',
    '230011 - Pabrik Produk Kimia Umum, mudah terbakar, termasuk biofuel dari minyak nabati dan oleokimia',
    '230012 - Pabrik Produk Kimia Umum tidak mudah terbakar',
    '23002 - Pabrik Produk Farmasi dan plester obat',
    '23003 - Obat Alami (Jamu)',
    '23004 - Pesticides dan bahan kimia pertanian',
    '230051 - Produk dasar pelarut',
    '230052 - Produk Dasar Air',
    '23006 - Pabrik Asam, Alkali',
    '23007 - Chlor - Elektrolisis Alkali',
    '23008 - Pabrik Pemisahan Udara (Produksi Gas Teknis, misalnya oksigen, nitrogen, hidrogen)',
    '23009 - Pembuatan, Aplikasi, dan penyimpanan Peroksida',
    '23010 - Lainnya dari 23006 - 23009',
    '230121 - Pabrik tinta - basis pelarut',
    '230122 - Pabrik tinta - dasar air',
    '23111 - Pembangkitan Hidrogen dari Gas Alam, Gas Kilang, atau Cairan',
    '23115 - Minyak pelumas dan gemuk dengan mencampur dan menggabungkan bahan yang dibeli termasuk pemrosesan oli yang digunakan kembali',
  ];

// Okupasi Controller
  ValueNotifier<String?> kelasKontruksiController =
      ValueNotifier<String?>(null);
  String? kelasKontruksi;
  List<String> kelasKontruksiList = [
    'Bangunan Kelas 1',
    'Bangunan Kelas 2',
    'Bangunan Kelas 3',
  ];
  List<String> filteredOkupasiList = [];
  TextEditingController okupasiSearchController = TextEditingController();

  CalculatorController() {
    filteredOkupasiList = List.from(okupasiList);
  }

  void filterOkupasi(String query) {
    if (query.isEmpty) {
      filteredOkupasiList = List.from(okupasiList);
    } else {
      filteredOkupasiList = okupasiList
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  // TahunController
  final TextEditingController tahunKebakaranController =
      TextEditingController();

  // Nilai Pertanggungan Kebakaran Controller
  final TextEditingController nilaiPertanggunganKebakaranController =
      TextEditingController();
}
