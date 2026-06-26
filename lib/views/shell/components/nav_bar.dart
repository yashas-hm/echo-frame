import 'package:echo_frame/constants/constants.dart';
import 'package:echo_frame/theme/theme.dart';
import 'package:echo_frame/utilities/utilities.dart';
import 'package:echo_frame/views/media/favorites_screen.dart';
import 'package:echo_frame/views/media/timeline_screen.dart';
import 'package:echo_frame/views/media/trash_screen.dart';
import 'package:echo_frame/views/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:go_router/go_router.dart';

typedef _NavDestination = ({String route, IconData icon, String label});

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  static const List<_NavDestination> _destinations = [
    (
      route: TimelineScreen.path,
      icon: Icons.grid_view_rounded,
      label: 'Library'
    ),
    (
      route: 'TODO',
      icon: Icons.photo_album_outlined,
      label: 'Albums'
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
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final showLabel = Prefs.showNavLabel;
    final currentRoute = GoRouterState.of(context).uri.path;

    return Container(
      width: Sizes.navBarWidth,
      height: context.height,
      padding: EdgeInsets.all(Sizes.edgePadding),
      color: colors.background,
      child: Material(
        color: KnownColors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: Sizes.edgePadding,
          children: [
            Padding(
              padding: EdgeInsets.all(Sizes.spacingRegular),
              child: Row(
                spacing: Sizes.spacingRegular,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.logoAsset,
                    height: Sizes.iconSizeLarge,
                    width: Sizes.iconSizeLarge,
                    fit: BoxFit.contain,
                  ),
                  Text.rich(
                    TextSpan(
                      text: 'Echo',
                      style: Styles.regularBold(color: colors.textPrimary),
                      children: [
                        TextSpan(
                          text: 'Frame',
                          style: Styles.regular(color: colors.textPrimary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(Sizes.cardPadding),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: colors.textPrimary.withValues(alpha: 0.2),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(Sizes.spacingMedium),
                  color: colors.surfacePrimary,
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: SingleChildScrollView(
                              child: Column(
                                spacing: Sizes.spacingSmallRegular,
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
                  ],
                ),
              ),
            ),
          ],
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
      SettingsScreen.path => () => context.push(destination.route),
      _ => () => context.go(destination.route),
    };
    return Material(
      color: currentRoute == destination.route
          ? colors.primaryColor.withValues(alpha: 0.6)
          : KnownColors.transparent,
      borderRadius: BorderRadius.circular(Sizes.maxFinite),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: callback,
        hoverColor: colors.onPrimary.hover,
        mouseCursor: SystemMouseCursors.click,
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: Sizes.spacingSmall,
            horizontal: Sizes.spacingRegular,
          ),
          alignment: Alignment.center,
          child: Row(
            spacing: Sizes.spacingExtraSmall,
            children: [
              Icon(
                destination.icon,
                size: Sizes.iconSizeRegular,
                color: colors.onPrimary,
              ),
              if (showLabel)
                Text(
                  destination.label,
                  style: Styles.small(
                    color: colors.onPrimary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
