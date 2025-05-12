import 'package:flipnews/myhomepage.dart';
import 'package:flipnews/view_models/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flipnews/theme.dart';
import 'package:flipnews/util.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
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
    //To set app brightness based on system brightness
    //final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "Lato");
    MaterialTheme theme = MaterialTheme(textTheme);
    final themeNotifier = ThemeNotifier(Brightness.light);
    return ValueListenableBuilder<Brightness>(
        valueListenable: themeNotifier,
      builder: (BuildContext context, Brightness value, Widget? child) {
          return Builder(
            builder: (context) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: title,
                theme: themeNotifier.value == Brightness.light
                    ? theme.light()
                    : theme.dark(),
                home: MyHomePage(title: title, themeNotifier:  themeNotifier),
              );
            }
          );
      },
    );
  }
}