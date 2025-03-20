import 'package:flutter/material.dart';
import 'package:mam/core/colors/app_color.dart';
import 'package:mam/core/fonts/font_size.dart';

class MiniNavbar extends StatefulWidget {
  final Function(String) onMenuItemTap;

  const MiniNavbar({super.key, required this.onMenuItemTap});

  @override
  MiniNavbarState createState() => MiniNavbarState();
}

class MiniNavbarState extends State<MiniNavbar> {
  String? _selectedLabel;

  final List<Map<String, dynamic>> _menuItems = [
    {'label': 'Aktivitas Hari Ini', 'icon': Icons.calendar_today},
    {'label': 'Aktivitas Mendatang', 'icon': Icons.schedule},
    {'label': 'Daftar Prospek', 'icon': Icons.list},
    {'label': 'Riwayat Nasabah', 'icon': Icons.people},
    {'label': 'Riwayat Absen', 'icon': Icons.history},
    {'label': 'Riwayat Aktivitas', 'icon': Icons.directions_run},
  ];

  void _handleTap(String label) {
    setState(() {
      _selectedLabel = (_selectedLabel == label) ? null : label;
    });
    widget.onMenuItemTap(
        _selectedLabel ?? 'Informasi'); // Kirim '' atau nilai default
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Row(
          children: List.generate(_menuItems.length, (i) {
            final item = _menuItems[i];
            final isSelected = item['label'] == _selectedLabel;
            return Padding(
              padding: EdgeInsets.only(
                left: i == 0 ? 0.0 : 10.0,
                right: i == _menuItems.length - 1 ? 0.0 : 10.0,
              ),
              child: GestureDetector(
                onTap: () => _handleTap(item['label']),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColor.backgroundMiniNavbarIconActive
                            : AppColor.backgroundMiniNavbarIconInactive,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        item['icon'],
                        size: 26,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: 50, // Set a fixed width for the text container
                      child: Text(
                        item['label'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: FontSize.miniNavbarText,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2, // Allow up to 2 lines for wrapping
                        overflow: TextOverflow
                            .ellipsis, // Handle overflow with ellipsis
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
