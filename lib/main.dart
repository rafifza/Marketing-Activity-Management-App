import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mam/core/routes/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mam/core/colors/app_color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final bool isLoggedIn = await _checkLoginStatus();
  final List<CameraDescription> cameras = await availableCameras();
  runApp(MyApp(isLoggedIn: isLoggedIn, cameras: cameras));
}

Future<bool> _checkLoginStatus() async {
  final prefs = await SharedPreferences.getInstance();
  final String? token = prefs.getString('access_token');
  return token != null;
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final List<CameraDescription> cameras;

  const MyApp({super.key, required this.isLoggedIn, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter(isLoggedIn, cameras),
      title: 'Tripa Mam',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColor.backgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColor.backgroundMiniNavbarIconInactive,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainScreen({super.key, required this.navigationShell});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.navigationShell.currentIndex;
  }

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
    widget.navigationShell.goBranch(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColor.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColor.backgroundColor,
          currentIndex: _currentIndex,
          onTap: _onTabSelected,
          selectedItemColor: AppColor.iconActive,
          unselectedItemColor: AppColor.iconInactive,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false, // Hides selected labels
          showUnselectedLabels: false, // Hides unselected labels
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled, size: 34),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate, size: 34),
              label: 'Kalkulator',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 34),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}
