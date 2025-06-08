import 'package:flipnews/presentation/app.dart' show App;
import 'package:flipnews/presentation/view_models/theme_notifier.dart' show ThemeNotifier;
import 'package:flutter/material.dart';
import 'package:flipnews/configurations/theme.dart';
import 'package:flipnews/utils/util.dart';
import 'package:firebase_core/firebase_core.dart';
import 'configurations/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FlipNews());
}

class FlipNews extends StatelessWidget {
  const FlipNews({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Flip News';
    TextTheme textTheme = createTextTheme(context, "Lato");
    MaterialTheme theme = MaterialTheme(textTheme);
    final themeNotifier = ThemeNotifier(Brightness.light);
    return App(themeNotifier: themeNotifier, title: title, theme: theme);
  }
}
