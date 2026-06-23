import 'dart:ui';

import 'package:echo_frame/constants/constants.dart';
import 'package:echo_frame/theme/theme.dart';
import 'package:echo_frame/utilities/utilities.dart';
import 'package:echo_frame/views/import/import_screen.dart';
import 'package:echo_frame/views/media/favorites_screen.dart';
import 'package:echo_frame/views/media/timeline_screen.dart';
import 'package:echo_frame/views/media/trash_screen.dart';
import 'package:echo_frame/views/settings/settings_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef _NavDestination = ({String route, IconData icon, String label});

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _isCollapsed = false;
  bool _showContent = true;

  static const double _collapsedWidth = 30;
  static const double _collapsedHeight = 60;
  static const Duration _duration = Durations.short4;
  static const Curve _curve = Curves.easeInOut;

  static const List<_NavDestination> _destinations = [
    (
      route: TimelineScreen.path,
      icon: Icons.grid_view_rounded,
      label: 'Library'
    ),
    (
      route: FavoritesScreen.path,
      icon: Icons.star_border_rounded,
      label: 'Starred'
    ),
    (
      route: TrashScreen.path,
      icon: Icons.delete_outline_rounded,
      label: 'Trash',
    ),
    (
      route: ImportScreen.path,
      icon: Icons.add_rounded,
      label: 'Import',
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => Future.delayed(
        Durations.extralong1,
        () => _onExit(null),
      ),
    );
  }

  void _onEnter(PointerEnterEvent _) => setState(() => _isCollapsed = false);

  void _onExit(PointerExitEvent? _) {
    setState(() {
      _isCollapsed = true;
      _showContent = false;
    });
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
          height: _isCollapsed ? expandedHeight * 0.5 : expandedHeight,
          width: Sizes.navBarWidth / (_isCollapsed ? 2 : 1),
          child: AnimatedContainer(
            duration: _duration,
            curve: _curve,
            width: _isCollapsed ? _collapsedWidth : Sizes.navBarWidth,
            height: _isCollapsed ? _collapsedHeight : expandedHeight,
            onEnd: () {
              if (!_isCollapsed) setState(() => _showContent = true);
            },
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
                          size: Sizes.iconSizeMedium,
                          color: colors.onPrimary,
                        ),
                      ),
                    ),
                  if (_showContent)
                    Positioned.fill(
                      child: Padding(
                        padding: EdgeInsets.all(Sizes.spacingSmallRegular),
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
    final VoidCallback callback = switch (destination.route) {
      SettingsScreen.path || ImportScreen.path => () =>
          context.push(destination.route),
      _ => () => context.go(destination.route),
    };
    return Material(
      color: currentRoute == destination.route
          ? colors.primaryColor.withValues(alpha: 0.6)
          : KnownColors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: callback,
        hoverColor: colors.onPrimary.hover,
        child: Container(
          margin: EdgeInsets.all(
            showLabel ? Sizes.iconWLabelPadding : Sizes.iconPadding,
          ),
          alignment: Alignment.center,
          child: Column(
            spacing: Sizes.spacingExtraSmall,
            children: [
              Icon(
                destination.icon,
                size: Sizes.iconSizeRegular,
                color: colors.onPrimary,
              ),
              if (showLabel)
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    destination.label,
                    style: Styles.small(
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
