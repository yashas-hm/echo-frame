import 'package:echo_frame/providers/ui_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

const Color primaryLight = Color(0xFF6bb5f2);

const Color secondaryLight = Color(0xFF5e9ff2);

const Color backgroundLight = Color(0xFFFAFAFA);

const Color elementLight = Color(0xFFE0DEDE);

const Color primaryDark = Color(0xFF36a0f7);

const Color secondaryDark = Color(0xFF3187f5);

const Color backgroundDark = Color(0xFF1C1C1C);

const Color elementDark = Color(0xFF2A2A2A);

Color get primaryColor => Theme.of(globalContext).colorScheme.primary;

Color get secondaryColor => Theme.of(globalContext).colorScheme.secondary;

Color get elementColor => Theme.of(globalContext).colorScheme.tertiary;

Color get backgroundColor => Theme.of(globalContext).colorScheme.background;
