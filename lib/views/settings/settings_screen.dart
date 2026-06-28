import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:echo_frame/components/buttons/buttons.dart';
import 'package:echo_frame/components/dialog.dart';
import 'package:echo_frame/components/snackbar.dart';
import 'package:echo_frame/components/dropdown.dart';
import 'package:echo_frame/constants/constants.dart';
import 'package:echo_frame/database/database.dart';
import 'package:echo_frame/theme/provider/theme_provider.dart';
import 'package:echo_frame/theme/theme.dart';
import 'package:echo_frame/utilities/utilities.dart';
import 'package:echo_frame/views/media/favourites/favorites_screen.dart'
    show favoritesProvider;
import 'package:echo_frame/views/media/timeline/timeline_screen.dart'
    show timelineProvider;
import 'package:echo_frame/views/media/trash/trash_screen.dart'
    show trashProvider;
import 'package:echo_frame/views/settings/shortcut_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

part 'provider/settings_provider.dart';

part 'provider/settings_state.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const String path = '/settings';

  static GoRoute get route =>
      GoRoute(
        path: path,
        builder: (_, __) => const SettingsScreen(),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colors;
    final settings = ref.watch(settingsProvider);
    final themeMode = ref
        .watch(appThemeProvider)
        .mode;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(Sizes.edgePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SpacerExtraExtraLarge(),
            Text(
              'General',
              style: Styles.subTitleBold(color: colors.textPrimary),
            ),
            SpacerRegular(),
            ..._settingTile(
              title: 'Library Root',
              subtitle: settings.activeLibraryRoot ?? 'No library selected',
              colors: colors,
              actionChild: settings.knownLibraryRoots.isNotEmpty
                  ? EFDropdown<String>(
                value: settings.activeLibraryRoot,
                hint: Text(
                  'Select library root',
                  style: Styles.micro(color: colors.textPrimary),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'NewRoot',
                    child: Row(
                      spacing: Sizes.spacingExtraSmall,
                      children: [
                        Text(
                          'New Library Root',
                          style: Styles.micro(color: colors.textPrimary),
                        ),
                        Icon(
                          Icons.add_rounded,
                          size: Sizes.iconSizeExtraSmall,
                          color: colors.textPrimary,
                        ),
                      ],
                    ),
                  ),
                  ...settings.knownLibraryRoots.map(
                        (path) =>
                        DropdownMenuItem(
                          value: path,
                          child: Text(
                            path,
                            style: Styles.micro(color: colors.textPrimary),
                          ),
                        ),
                  ),
                ],
                onChanged: (path) {
                  if (path == 'NewRoot') {
                    _addLibrary(context, ref);
                    return;
                  }
                  if (path != null &&
                      path != settings.activeLibraryRoot) {
                    ref
                        .read(settingsProvider.notifier)
                        .switchLibrary(path);
                  }
                },
              )
                  : EFIconButton(
                icon: Icons.add_rounded,
                onPressed: () => _addLibrary(context, ref),
              ),
            ),
            ..._settingTile(
              title: 'Theme',
              subtitle: 'Choose how EchoFrame looks',
              colors: colors,
              actionChild: EFDropdown<ThemeMode>(
                value: themeMode,
                items: [
                  DropdownMenuItem(
                    value: ThemeMode.system,
                    child: Text(
                      'System',
                      style: Styles.small(color: colors.textPrimary),
                    ),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text(
                      'Light',
                      style: Styles.small(color: colors.textPrimary),
                    ),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text(
                      'Dark',
                      style: Styles.small(color: colors.textPrimary),
                    ),
                  ),
                ],
                onChanged: (mode) {
                  if (mode != null) {
                    ref.read(appThemeProvider.notifier).setMode(mode);
                  }
                },
              ),
            ),
            ..._settingTile(
              title: 'Navigation bar label',
              subtitle: 'Show text labels below navigation icons',
              colors: colors,
              actionChild: Switch(
                value: settings.showNavLabel,
                onChanged: ref
                    .read(settingsProvider.notifier)
                    .setShowNavLabel,
              ),
            ),
            SpacerRegular(),
            Text(
              'Sync Settings',
              style: Styles.subTitleBold(color: colors.textPrimary),
            ),
            SpacerRegular(),
            ..._settingTile(
              title: 'Export Settings',
              subtitle: 'Back up current settings to the active library',
              colors: colors,
              actionChild: EFPrimaryButton(
                text: 'Export',
                icon: Icons.save_rounded,
                onPressed: () => _saveSettings(context, ref),
              ),
            ),
            ..._settingTile(
              title: 'Import Settings',
              subtitle: 'Restore settings from a saved backup',
              colors: colors,
              actionChild: EFPrimaryButton(
                text: 'Import',
                icon: Icons.download_rounded,
                onPressed: () => _importSettings(context, ref),
              ),
            ),
            ..._settingTile(
              title: 'Reset Settings',
              subtitle: 'Restore appearance and display defaults',
              colors: colors,
              actionChild: EFErrorButton.flat(
                text: 'Reset',
                onPressed: () => _confirmReset(context, ref),
              ),
            ),
            SpacerRegular(),
            InkWell(
              onTap: () => context.push(ShortcutScreen.path),
              mouseCursor: SystemMouseCursors.click,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Sizes.spacingExtraSmall,
                ),
                child: Row(
                  children: [
                    Text(
                      'Shortcuts',
                      style: Styles.subTitleBold(color: colors.textPrimary),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_right_rounded,
                      size: Sizes.iconSizeRegular,
                      color: colors.textPrimary,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    // TODO: add Privacy Policy link
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    spacing: Sizes.spacingExtraSmall,
                    children: [
                      Icon(
                        Icons.privacy_tip_outlined,
                        size: Sizes.iconSizeExtraSmall,
                        color: colors.textSecondary.withValues(alpha: 0.5),
                      ),
                      Text(
                        'Privacy Policy',
                        style: Styles.micro(
                          color: colors.textSecondary.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SpacerSmall(),
            Center(
              child: Text.rich(
                TextSpan(
                  text: 'Version: ',
                  style: Styles.micro(
                    color: colors.textSecondary.withValues(alpha: 0.5),
                  ),
                  children: [
                    TextSpan(
                      text: 'v0.0.1-alpha+1',
                      style: Styles.microBold(
                        color: colors.textSecondary.withValues(alpha: 0.5),
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

  Future<void> _addLibrary(BuildContext context, WidgetRef ref) async {
    final path = await FilePicker.getDirectoryPath(
      dialogTitle: 'Select Library Folder',
    );
    if (path == null || !context.mounted) return;
    final result = await ref.read(settingsProvider.notifier).addLibrary(path);
    if (!context.mounted) return;
    if (!result.success) {
      EFSnackbar.showError(context, message: 'Failed to open library');
    }
  }

  Future<void> _saveSettings(BuildContext context, WidgetRef ref) async {
    final ok = await ref.read(settingsProvider.notifier).saveSettings();
    if (!context.mounted) return;
    if (ok) {
      EFSnackbar.showSuccess(context, message: 'Settings saved to library');
    } else {
      EFSnackbar.showError(context, message: 'No active library selected');
    }
  }

  Future<void> _importSettings(BuildContext context, WidgetRef ref) async {
    final result = await ref.read(settingsProvider.notifier).importSettings();
    if (!context.mounted) return;
    if (result == null) {
      await EFDialog.show(
        context,
        title: 'No saved settings found',
        description: 'Save your settings first using the Save button above.',
        confirmText: 'Ok',
        showCancel: false,
      );
      return;
    }
    if (result) {
      EFSnackbar.showSuccess(context, message: 'Settings imported');
    } else {
      EFSnackbar.showError(context, message: 'Failed to import settings');
    }
  }

  Future<void> _confirmReset(BuildContext context, WidgetRef ref) async {
    final confirmed = await EFDialog.show(
      context,
      title: 'Reset Settings',
      description: 'This will restore theme and display defaults, and clear '
          'all known library roots except the active one.',
      confirmText: 'Cancel',
      cancelText: 'Reset',
    );
    if (confirmed != true) {
      ref.read(settingsProvider.notifier).reset();
    }
  }

  List<Widget> _settingTile({
    required String title,
    required AppThemeColors colors,
    String subtitle = '',
    Widget? actionChild,
  }) =>
      [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: Sizes.spacingRegular,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: Sizes.spacingExtraSmall,
                children: [
                  Text(
                    title,
                    style: Styles.smallRegular(color: colors.textPrimary),
                  ),
                  Text(
                    subtitle,
                    style: Styles.small(color: colors.textSecondary),
                  ),
                ],
              ),
            ),
            if (actionChild != null) ...[
              actionChild,
            ],
          ],
        ),
        SpacerSmallRegular(),
      ];
}
