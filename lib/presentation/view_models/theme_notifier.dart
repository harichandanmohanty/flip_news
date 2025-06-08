import 'package:flutter/material.dart';

class ThemeNotifier extends ValueNotifier<Brightness> {
  ThemeNotifier(super.value);

  toggleMode(int index) {
    value = index ==  0 ? Brightness.light : Brightness.dark;
  }
}
