import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/body_part.dart';
import '../../features/onboarding/onboarding_page.dart';
import '../../features/overview/overview_page.dart';
import '../../features/saved_scans/saved_scans_page.dart';
import '../../features/saved_scans/screens/scan_detail_screen.dart';
import '../../features/scan/scan_page.dart';
import '../../features/scan/screens/body_scan_walkthrough_screen.dart';
import '../../features/scan/screens/capture_options_screen.dart';
import '../../features/scan/screens/custom_camera_screen.dart';
import '../../features/scan/screens/scan_review_screen.dart';
import '../../features/scan/screens/single_scan_screen.dart';
import '../../features/scan/screens/sub_part_selection_screen.dart';
import '../../features/scan/screens/sunscreen_scan_screen.dart';
import '../../features/settings/screens/report_detail_screen.dart';
import '../../features/settings/screens/reports_screen.dart';
import '../../features/settings/settings_page.dart';

part 'app_router.g.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Overview',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: 'Scans',
          ),
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            selectedIcon: Icon(Icons.add_circle),
            label: 'Add Scan',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    redirect: (context, state) async {
      if (state.matchedLocation == '/') {
        final prefs = await SharedPreferences.getInstance();
        final completed = prefs.getBool('hasCompletedOnboarding') ?? false;
        return completed ? '/overview' : '/onboarding';
      }
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SizedBox.shrink()),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/overview',
                builder: (context, state) => const OverviewPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/scans',
                builder: (context, state) => const SavedScansPage(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) =>
                        ScanDetailScreen(spotId: state.pathParameters['id']!),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/add-scan',
                builder: (context, state) => const ScanPage(),
                routes: [
                  GoRoute(
                    path: 'single',
                    builder: (context, state) => const SingleScanScreen(),
                  ),
                  GoRoute(
                    path: 'sunscreen',
                    builder: (context, state) => const SunscreenScanScreen(),
                  ),
                  GoRoute(
                    path: 'sub-parts',
                    builder: (context, state) {
                      final extra = state.extra as Map<String, dynamic>? ?? {};
                      final bp = extra['bodyPart'] as String? ?? '';
                      return SubPartSelectionScreen(
                        bodyPart: BodyPart.values.byName(bp),
                      );
                    },
                  ),
                  GoRoute(
                    path: 'capture',
                    builder: (context, state) {
                      final extra = state.extra as Map<String, dynamic>? ?? {};
                      final bp = extra['bodyPart'] as String? ?? '';
                      final sp = extra['subPart'] as String?;
                      return CaptureOptionsScreen(
                        bodyPart: BodyPart.values.byName(bp),
                        subPart: sp != null
                            ? BodySubPart.values.byName(sp)
                            : null,
                      );
                    },
                  ),
                  GoRoute(
                    path: 'camera',
                    builder: (context, state) {
                      final extra = state.extra as Map<String, dynamic>? ?? {};
                      final bp = extra['bodyPart'] as String? ?? '';
                      final sp = extra['subPart'] as String?;
                      return CustomCameraScreen(
                        bodyPart: BodyPart.values.byName(bp),
                        subPart: sp != null
                            ? BodySubPart.values.byName(sp)
                            : null,
                      );
                    },
                  ),
                  GoRoute(
                    path: 'review',
                    builder: (context, state) {
                      final extra = state.extra as Map<String, dynamic>? ?? {};
                      final bp = extra['bodyPart'] as String? ?? '';
                      final sp = extra['subPart'] as String?;
                      final spotId = extra['spotId'] as String?;
                      final imageBytes = extra['imageBytes'] as Uint8List?;
                      return ScanReviewScreen(
                        bodyPart: BodyPart.values.byName(bp),
                        subPart: sp != null
                            ? BodySubPart.values.byName(sp)
                            : null,
                        spotId: spotId,
                        imageBytes: imageBytes,
                      );
                    },
                  ),
                  GoRoute(
                    path: 'walkthrough',
                    builder: (context, state) =>
                        const BodyScanWalkthroughScreen(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsPage(),
                routes: [
                  GoRoute(
                    path: 'reports',
                    builder: (context, state) => const ReportsScreen(),
                  ),
                  GoRoute(
                    path: 'reports/:reportId',
                    builder: (context, state) => ReportDetailScreen(
                      reportId: state.pathParameters['reportId']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
