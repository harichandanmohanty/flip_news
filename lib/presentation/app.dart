import 'package:flipnews/configurations/theme.dart';
import 'package:flipnews/presentation/home/home_page.dart';
import 'package:flipnews/presentation/view_models/theme_notifier.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.themeNotifier,
    required this.title,
    required this.theme,
  });

  final ThemeNotifier themeNotifier;
  final String title;
  final MaterialTheme theme;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Brightness>(
      valueListenable: themeNotifier,
      builder: (BuildContext context, Brightness value, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          theme: themeNotifier.value == Brightness.light
              ? theme.light()
              : theme.dark(),
          home: HomePage(title: title, themeNotifier: themeNotifier),
        );
      },
    );
  }
}