import 'package:flutter/material.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:go_router/go_router.dart';
import 'package:mam/core/colors/app_color.dart';
import 'package:mam/core/fonts/font_size.dart';
import 'package:mam/core/routes/app_route.dart';
import 'package:mam/feature/dashboard/model/aktivitas_kedepan_model.dart';
import 'package:mam/feature/dashboard/model/daftar_prospek_model.dart';
import 'package:mam/feature/dashboard/model/informasi_model.dart';
import 'package:mam/feature/dashboard/model/riwayat_absen_model.dart';
import 'package:mam/feature/dashboard/model/riwayat_aktivitas_model.dart';
import 'package:mam/feature/dashboard/presentation/widget/aktivitas_kedepan.dart';
import 'package:mam/feature/dashboard/presentation/widget/checkin_checkout_button.dart';
import 'package:mam/feature/dashboard/presentation/widget/daftar_prospek.dart';
import 'package:mam/feature/dashboard/presentation/widget/informasi.dart';
import 'package:mam/feature/dashboard/presentation/widget/mini_navbar.dart';
import 'package:mam/feature/dashboard/presentation/widget/aktivitas_hari_ini.dart';
import 'package:mam/feature/dashboard/model/aktivitas_hari_ini_model.dart';
import 'package:mam/feature/dashboard/presentation/widget/riwayat_absen.dart';
import 'package:mam/feature/dashboard/presentation/widget/riwayat_aktivitas.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> {
  String _selectedLabel = 'Informasi';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  void _onMenuItemTap(String label) {
    setState(() {
      if (_selectedLabel == label) {
        _selectedLabel = 'Informasi'; // Reset to default
      } else {
        _selectedLabel = label;
      }
      _searchQuery = ''; // Reset search query
      _searchController.clear();
    });
  }

  Widget _buildContent() {
    switch (_selectedLabel) {
      case 'Aktivitas Hari Ini':
        return AktivitasHariIniWidget(
          aktivitasList: dummyAktivitasHariIni
              .where((aktivitas) =>
                  aktivitas.title.toLowerCase().contains(_searchQuery) ||
                  aktivitas.description.toLowerCase().contains(_searchQuery) ||
                  aktivitas.date
                      .toString()
                      .toLowerCase()
                      .contains(_searchQuery))
              .toList(),
        );

      case 'Aktivitas Mendatang':
        return AktivitasKedepanWidget(
          aktivitasList: dummyAktivitasKedepan
              .where((aktivitas) =>
                  aktivitas.title.toLowerCase().contains(_searchQuery) ||
                  aktivitas.description.toLowerCase().contains(_searchQuery) ||
                  aktivitas.date
                      .toString()
                      .toLowerCase()
                      .contains(_searchQuery))
              .toList(),
        );

      case 'Daftar Prospek':
        return DaftarProspekWidget(
          prospekList: dummyProspek
              .where((prospek) =>
                      prospek.title.toLowerCase().contains(_searchQuery) ||
                      prospek.description
                          .toLowerCase()
                          .contains(_searchQuery) ||
                      prospek.isCompleted
                          .toLowerCase()
                          .contains(_searchQuery) // Add more fields as needed
                  )
              .toList(),
        );
      case 'Riwayat Absen':
        return HistoryAbsenWidget(
          prospekList: dummyHistoryAbsen
              .where((absen) =>
                  absen.day.toLowerCase().contains(_searchQuery) ||
                  absen.date
                      .toString()
                      .toLowerCase()
                      .contains(_searchQuery) || // Convert DateTime to string
                  '${absen.checkInTime.hour}:${absen.checkInTime.minute}'
                      .contains(_searchQuery) || // Format TimeOfDay
                  '${absen.checkOutTime.hour}:${absen.checkOutTime.minute}'
                      .contains(_searchQuery))
              .toList(),
        );
      case 'Riwayat Aktivitas':
        return HistoryAktivitasWidget(
          aktivitasList: dummyHistoryAktivitas
              .where((aktivitas) =>
                      aktivitas.title.toLowerCase().contains(_searchQuery) ||
                      aktivitas.description
                          .toLowerCase()
                          .contains(_searchQuery) ||
                      aktivitas.date
                          .toString()
                          .toLowerCase()
                          .contains(_searchQuery) // Add more fields as needed
                  )
              .toList(),
        );
      default:
        return InformasiWidget(informasiList: informasiDummy);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableHome(
      title: Text(''),
      headerWidget: _buildHeaderWidget(context),
      body: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MiniNavbar(onMenuItemTap: _onMenuItemTap),
              const SizedBox(height: 20),

              // **Label Judul**
              Text(
                _selectedLabel,
                style: const TextStyle(
                  fontSize: FontSize.heading2,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(
                  height: 10), // Beri jarak sebelum search bar dan tombol +

              // **Search Bar + Button Tambah**
              Row(
                children: [
                  // **Search Bar**
                  if (_selectedLabel != 'Informasi')
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value.toLowerCase();
                            });
                          },
                          decoration: const InputDecoration(
                            hintText: 'Search...',
                            border: InputBorder.none,
                            icon: Icon(Icons.search, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),

                  const SizedBox(width: 10),

                  // **Tombol +**
                  if (_selectedLabel == 'Aktivitas Hari Ini' ||
                      _selectedLabel == 'Aktivitas Mendatang' ||
                      _selectedLabel == 'Riwayat Aktivitas')
                    GestureDetector(
                      onTap: () {
                        context.push(AppRoutePaths.buataktivitas);
                      },
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: const BoxDecoration(
                          color: AppColor.backgroundIcon,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add,
                            color: Colors.white, size: 28),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 20), // Beri jarak sebelum kontennya

              // **Content berdasarkan menu yang dipilih**
              _buildContent(),
            ],
          ),
        ),
      ],
      fullyStretchable: true,
      expandedBody: _buildExpandedBody(),
      backgroundColor: Colors.white,
      appBarColor: AppColor.backgroundColor,
    );
  }

  Widget _buildHeaderWidget(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Background image positioned at the bottom
          Positioned(
            bottom: -50,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/artboard.png', // Replace with your image's asset path
              width: screenWidth,
              fit: BoxFit.fitWidth,
            ),
          ),
          // Content with horizontal padding
          Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Minimize vertical spacing
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align left elements to start
                children: [
                  // First Row: Logo on the left
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/logo.png', // Replace with your logo's asset path
                        width: 130, // Adjust as needed
                      ),
                    ],
                  ),
                  // Second Row: Name on the left, buttons on the right
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Name on the left
                      // Flexible(
                      //   child: Text(
                      //     'John Doe Membadut',
                      //     style: const TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //     softWrap: true,
                      //     overflow: TextOverflow.clip,
                      //   ),
                      // ),
                      // Buttons on the right
                      SizedBox(
                        width: 100,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CheckInCheckOutButton(
                                  text: 'Check In', onPressed: () {}),
                              SizedBox(width: 10), // Spacing between buttons
                              Text('09.11')
                            ],
                          ),

                          const SizedBox(height: 10), // Spacing between buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CheckInCheckOutButton(
                                  text: 'Check Out', onPressed: () {}),
                              SizedBox(width: 10), // Spacing between buttons
                              Text('12.55')
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedBody() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Ngapain cb',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
