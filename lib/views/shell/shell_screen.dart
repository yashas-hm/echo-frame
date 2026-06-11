import 'package:echo_frame/views/favorites/favorites_screen.dart';
import 'package:echo_frame/views/import/import_screen.dart';
import 'package:echo_frame/views/organizer/organizer_screen.dart';
import 'package:echo_frame/views/search/search_screen.dart';
import 'package:echo_frame/views/settings/settings_screen.dart';
import 'package:echo_frame/views/timeline/timeline_screen.dart';
import 'package:echo_frame/widgets/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShellScreen extends StatelessWidget {
  const ShellScreen({super.key, required this.child});

  final Widget child;

  static const _destinations = [
    (route: TimelineScreen.path, icon: Icons.grid_view_rounded, label: 'Library'),
    (route: SearchScreen.path, icon: Icons.search_rounded, label: 'Search'),
    (
      route: FavoritesScreen.path,
      icon: Icons.favorite_outline_rounded,
      label: 'Favourites'
    ),
    (
      route: OrganizerScreen.path,
      icon: Icons.drive_folder_upload_outlined,
      label: 'Organize'
    ),
    (route: ImportScreen.path, icon: Icons.download_rounded, label: 'Import'),
    (route: SettingsScreen.path, icon: Icons.settings_outlined, label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final selectedIndex = _destinations
        .indexWhere((d) => location.startsWith(d.route))
        .clamp(0, _destinations.length - 1);

    return Scaffold(
      body: Column(
        children: [
          const TitleBar(),
          const Divider(height: 1, thickness: 1),
          Expanded(
            child: Row(
              children: [
                NavigationRail(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (i) =>
                      context.go(_destinations[i].route),
                  labelType: NavigationRailLabelType.all,
                  destinations: [
                    for (final d in _destinations)
                      NavigationRailDestination(
                        icon: Icon(d.icon),
                        label: Text(d.label),
                      ),
                  ],
                ),
                const VerticalDivider(width: 1, thickness: 1),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
