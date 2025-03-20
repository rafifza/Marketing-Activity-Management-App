import 'package:camera_platform_interface/src/types/camera_description.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mam/core/routes/app_route.dart';
import 'package:mam/feature/buataktivitas/presentation/buat_aktivitas_page.dart';
import 'package:mam/feature/calculator/presentation/calculator_page.dart';
import 'package:mam/feature/dashboard/model/aktivitas_base_model.dart';
import 'package:mam/feature/dashboard/model/daftar_prospek_model.dart';
import 'package:mam/feature/dashboard/presentation/dashboard_page.dart';
import 'package:mam/feature/dashboard/presentation/widget/batalkan_aktivitas.dart';
import 'package:mam/feature/dashboard/presentation/widget/bukti_aktivitas.dart';
import 'package:mam/feature/dashboard/presentation/widget/camera.dart';
import 'package:mam/feature/dashboard/presentation/widget/detail_aktivitas.dart';
import 'package:mam/feature/dashboard/presentation/widget/detail_prospek.dart';
import 'package:mam/feature/dashboard/presentation/widget/perkembangan_aktivitas.dart';
import 'package:mam/feature/dashboard/presentation/widget/reschedule_aktivitas.dart';
import 'package:mam/feature/dashboard/presentation/widget/signature_page.dart';
import 'package:mam/feature/dashboard/presentation/widget/ubah_perkembangan.dart';
import 'package:mam/feature/login/presentation/login.dart';
import 'package:mam/feature/profile/presentation/profile_page.dart';
import 'package:mam/main.dart';

GoRouter appRouter(bool isLoggedIn, List<CameraDescription> cameras) {
  return GoRouter(
    initialLocation:
        isLoggedIn ? AppRoutePaths.dashboard : AppRoutePaths.dashboard,
    routes: [
      GoRoute(
        name: AppRouteNames.login,
        path: AppRoutePaths.login,
        pageBuilder: (context, state) => _fadeTransitionPage(
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        name: AppRouteNames.buataktivitas, // Change the name to avoid conflicts
        path: AppRoutePaths.buataktivitas,
        pageBuilder: (context, state) => _fadeTransitionPage(
          child: const BuatAktivitasPage(),
        ),
      ),
      GoRoute(
        name: AppRouteNames.detailaktivitas,
        path: AppRoutePaths.detailaktivitas,
        pageBuilder: (context, state) {
          final aktivitas = state.extra;
          if (aktivitas is AktivitasBase) {
            return _fadeTransitionPage(
              child: DetailAktivitas(aktivitas: aktivitas),
            );
          } else {
            throw Exception("Invalid data passed to DetailAktivitasPage");
          }
        },
      ),
      GoRoute(
        name: AppRouteNames.perkembanganaktivitas,
        path: AppRoutePaths.perkembanganaktivitas,
        pageBuilder: (context, state) {
          final aktivitas = state.extra;
          if (aktivitas is AktivitasBase) {
            return _fadeTransitionPage(
              child: PerkembanganAktivitas(aktivitas: aktivitas),
            );
          } else {
            throw Exception("Invalid data passed to Mulai Aktivitas");
          }
        },
      ),
      GoRoute(
        name: AppRouteNames.buktiaktivitas,
        path: AppRoutePaths.buktiaktivitas,
        pageBuilder: (context, state) {
          final aktivitas = state.extra;
          if (aktivitas is AktivitasBase) {
            return _fadeTransitionPage(
              child: BuktiAktivitas(aktivitas: aktivitas),
            );
          } else {
            throw Exception("Invalid data passed to Bukti Aktivitas");
          }
        },
      ),
      GoRoute(
        name: AppRouteNames.batalaktivitas,
        path: AppRoutePaths.batalaktivitas,
        pageBuilder: (context, state) {
          final aktivitas = state.extra;
          if (aktivitas is AktivitasBase) {
            return _fadeTransitionPage(
              child: BatalkanAktivitas(aktivitas: aktivitas),
            );
          } else {
            throw Exception("Invalid data passed to BatalAktivitasPage");
          }
        },
      ),
      GoRoute(
        name: AppRouteNames.rescheduleaktivitas,
        path: AppRoutePaths.rescheduleaktivitas,
        pageBuilder: (context, state) {
          final aktivitas = state.extra;
          if (aktivitas is AktivitasBase) {
            return _fadeTransitionPage(
              child: RescheduleAktivitas(aktivitas: aktivitas),
            );
          } else {
            throw Exception("Invalid data passed to BatalAktivitasPage");
          }
        },
      ),
      GoRoute(
        name: AppRouteNames.ubahperkembangan,
        path: AppRoutePaths.ubahperkembangan,
        pageBuilder: (context, state) {
          final aktivitas = state.extra;
          if (aktivitas is AktivitasBase) {
            return _fadeTransitionPage(
              child: UbahPerkembangan(aktivitas: aktivitas),
            );
          } else {
            throw Exception("Invalid data passed to BatalAktivitasPage");
          }
        },
      ),
      GoRoute(
        name: AppRouteNames.camera,
        path: AppRoutePaths.camera,
        pageBuilder: (context, state) {
          final cameras =
              state.extra as List<CameraDescription>?; // Ensure proper type
          return MaterialPage(
            child: CameraPage(
                cameras: cameras ?? []), // Provide a default empty list
          );
        },
      ),
      GoRoute(
        name: AppRouteNames.signature,
        path: AppRoutePaths.signature,
        pageBuilder: (context, state) => MaterialPage(
          child: SignaturePage(),
        ),
      ),
      GoRoute(
        name: AppRouteNames.detailprospek,
        path: AppRoutePaths.detailprospek,
        pageBuilder: (context, state) {
          final daftarProspek = state.extra;
          if (daftarProspek is DaftarProspekModel) {
            return _fadeTransitionPage(
              child: DetailProspek(daftarProspek: daftarProspek),
            );
          } else {
            throw Exception("Invalid data passed to Detail Prospek");
          }
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutePaths.dashboard,
                builder: (context, state) => const DashboardPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutePaths.calculator,
                builder: (context, state) => const CalculatorPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutePaths.profile,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

/// Custom function to apply fade transition
CustomTransitionPage _fadeTransitionPage({required Widget child}) {
  return CustomTransitionPage(
    opaque: false,
    transitionDuration: const Duration(milliseconds: 300), // Adjust speed here
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}
