part of '../settings_screen.dart';

class SettingsState {
  const SettingsState({
    required this.showNavLabel,
    required this.activeLibraryRoot,
    required this.knownLibraryRoots,
  });

  final bool showNavLabel;
  final String? activeLibraryRoot;
  final List<String> knownLibraryRoots;

  SettingsState copyWith({
    bool? showNavLabel,
    String? activeLibraryRoot,
    List<String>? knownLibraryRoots,
  }) =>
      SettingsState(
        showNavLabel: showNavLabel ?? this.showNavLabel,
        activeLibraryRoot: activeLibraryRoot ?? this.activeLibraryRoot,
        knownLibraryRoots: knownLibraryRoots ?? this.knownLibraryRoots,
      );
}
