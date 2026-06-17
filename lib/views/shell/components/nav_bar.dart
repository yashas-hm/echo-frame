import 'dart:ui';

import 'package:echo_frame/constants/constants.dart';
import 'package:echo_frame/theme/theme.dart';
import 'package:echo_frame/utilities/utilities.dart';
import 'package:echo_frame/views/favorites/favorites_screen.dart';
import 'package:echo_frame/views/import/import_screen.dart';
import 'package:echo_frame/views/organizer/organizer_screen.dart';
import 'package:echo_frame/views/settings/settings_screen.dart';
import 'package:echo_frame/views/timeline/timeline_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef _NavDestination = ({String route, IconData icon, String label});

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _showContent = true;

  static const double _collapsedWidth = 30;
  static const double _collapsedHeight = 60;
  static const Duration _duration = Durations.medium1;
  static const Curve _curve = Curves.easeInOut;

  static const List<_NavDestination> _destinations = [
    (
      route: TimelineScreen.path,
      icon: Icons.grid_view_rounded,
      label: 'Library'
    ),
    (
      route: FavoritesScreen.path,
      icon: Icons.favorite_outline_rounded,
      label: 'Favorites'
    ),
    (
      route: OrganizerScreen.path,
      icon: Icons.drive_folder_upload_outlined,
      label: 'Organize'
    ),
    (route: ImportScreen.path, icon: Icons.download_rounded, label: 'Import'),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        setState(() => _showContent = true);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Future.delayed(
        Durations.extralong1,
        () => _onExit(null),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onEnter(PointerEnterEvent _) => _controller.reverse();

  void _onExit(PointerExitEvent? _) {
    setState(() => _showContent = false);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final showLabel = Prefs.showNavLabel;
    final expandedHeight = context.height * 0.8;
    final currentRoute = GoRouterState.of(context).uri.path;

    return Align(
      alignment: Alignment.centerRight,
      child: MouseRegion(
        onEnter: _onEnter,
        onExit: _onExit,
        child: Container(
          alignment: Alignment.centerRight,
          height: expandedHeight,
          width: Sizes.navBarWidth * 1.5,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final t = _curve.transform(_controller.value);
              final width = lerpDouble(Sizes.navBarWidth, _collapsedWidth, t)!;
              final height = lerpDouble(expandedHeight, _collapsedHeight, t)!;

              return Container(
                width: width,
                height: height,
                margin: EdgeInsets.all(Sizes.spacingMedium),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: colors.textPrimary.withValues(alpha: 0.2),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(Sizes.navBarWidth),
                  color: colors.textPrimary.withValues(alpha: 0.1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Sizes.navBarWidth),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                          child: const SizedBox.expand(),
                        ),
                      ),
                      if (!_showContent)
                        Center(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Icon(
                              Icons.chevron_left,
                              size: 25,
                              color: colors.onPrimary,
                            ),
                          ),
                        ),
                      if (_showContent)
                        Positioned.fill(
                          child: Padding(
                          padding: EdgeInsets.all(Sizes.spacingRegular),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: SingleChildScrollView(
                                  child: Column(
                                    spacing: Sizes.spacingSmall,
                                    children: [
                                      for (final dest in _destinations)
                                        _tappableIcon(
                                          dest,
                                          colors,
                                          showLabel: showLabel,
                                          currentRoute: currentRoute,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              _tappableIcon(
                                (
                                  route: SettingsScreen.path,
                                  icon: Icons.settings_outlined,
                                  label: 'Settings',
                                ),
                                colors,
                                showLabel: showLabel,
                                currentRoute: currentRoute,
                              ),
                            ],
                          ),
                        ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _tappableIcon(
    _NavDestination destination,
    AppThemeColors colors, {
    bool showLabel = false,
    required String currentRoute,
  }) {
    return Material(
      color: currentRoute == destination.route
          ? colors.primaryColor.withValues(alpha: 0.6)
          : KnownColors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.go(destination.route),
        hoverColor: colors.onPrimary.withValues(alpha: 0.2),
        child: Container(
          margin: EdgeInsets.all(Sizes.iconWLabelPadding),
          alignment: Alignment.center,
          child: Column(
            spacing: Sizes.spacingExtraSmall,
            children: [
              Icon(destination.icon, size: 20, color: colors.onPrimary),
              if (showLabel)
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    destination.label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: colors.onPrimary,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
