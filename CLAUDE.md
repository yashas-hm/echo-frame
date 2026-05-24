# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
flutter run -d macos          # run on macOS (primary target)
flutter build macos --release # production build
flutter test                  # run all tests
flutter test test/foo_test.dart # run a single test file
flutter analyze               # lint
flutter pub get               # install dependencies
```

## Architecture

EchoFrame is an offline-first photo/video library manager for desktop. The full architectural plan is in `docs/AI/architecture.md`. The plugin plan for `media_metadata_plus` is in `docs/AI/plugin_plan.md`.

**Core design decisions:**
- Pure Flutter/Dart — no native engine or FFI in the main app
- Source of truth is the folder structure on disk: `YYYY/MonthName/` (e.g. `2021/January/`)
- Each month folder gets a `.echo_index.json` written once after sorting, caching EXIF metadata so it is never re-read from files
- No thumbnail generation — `Image.file(file, cacheWidth: 150)` lets Flutter decode at display size
- Heavy one-time operations (EXIF reading, file sorting) run in `compute()` isolates
- `media_metadata_plus` (published to pub.dev by this project) handles HEIC + video metadata cross-platform via Rust

**Planned dependencies not yet added:** `go_router`, `media_metadata_plus`, `path_provider`

## Theme System

The theme lives entirely in `lib/theme/` and uses Dart `part`/`part of` to form a single library:

- `theme.dart` — library root, imports Flutter + Google Fonts, declares `part` files
- `colors.dart` — `KnownColors` (raw palette) and `AppThemeColors` (abstract interface)
- `colors_light_theme.dart` / `colors_dark_theme.dart` — concrete implementations
- `app_themes.dart` — `EchoFrameThemes` builds `ThemeData` from an `AppThemeColors`

To add a new color token: add it to `AppThemeColors` as an abstract getter, then implement it in both `LightColors` and `DarkColors`. Never reference `KnownColors` directly outside of the theme files.

**Brand palette:** sky blues (`sky200`–`sky500`) for primary/secondary, neutral grays (`neutral100`, `neutral800`, `neutral950`) for backgrounds.

## State Management

Riverpod with the `Notifier`/`NotifierProvider` pattern throughout. The only current provider is `appThemeProvider` in `lib/theme/provider/theme_provider.dart`.

`AppThemeState` carries both `ThemeMode` and the resolved `AppThemeColors` — widgets that need color tokens read `ref.watch(appThemeProvider).colors` rather than `Theme.of(context)`.

`Prefs` (`lib/utilities/shared_pref_utils.dart`) is a static wrapper around `SharedPreferences`, initialized in `main()` before `runApp()`. Currently only persists `themeMode`.

## Constants

All constants live in `lib/constants/constants.dart` as a barrel using `part` files:

- `Keys` — `SharedPreferences` key strings
- `Sizes` — window constraints (`kMinWindowSize`, `kInitWindowWidth/Height`, `kWindowAspectRatio`)
- `Spacings`, `Styles`, `Durations`, `Routes` — currently empty part files, ready to populate

## Models

- `EchoImage` (`lib/models/image_modoel.dart`) — `path` + optional `Image` + optional `EchoExifData`
- `EchoExifData` (`lib/models/exif_data_model.dart`) — id, title, lat/lon, createdAt, modifiedAt, faces