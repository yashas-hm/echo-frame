import 'package:echo_frame/widgets/title_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShellScreen extends StatelessWidget {
  const ShellScreen({super.key, required this.child});

  final Widget child;

  static const _destinations = [
    (route: '/timeline', icon: Icons.grid_view_rounded, label: 'Library'),
    (route: '/search', icon: Icons.search_rounded, label: 'Search'),
    (route: '/favorites', icon: Icons.favorite_outline_rounded, label: 'Favourites'),
    (route: '/organize', icon: Icons.drive_folder_upload_outlined, label: 'Organize'),
    (route: '/import', icon: Icons.download_rounded, label: 'Import'),
    (route: '/settings', icon: Icons.settings_outlined, label: 'Settings'),
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
