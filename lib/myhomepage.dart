import 'package:flipnews/presentation/news_feed_list.dart';
import 'package:flipnews/presentation/widgets/gradient_text.dart';
import 'package:flipnews/view_models/theme_notifier.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage(
      {super.key, required this.title, required  this.themeNotifier,});

  final String title;
  final ThemeNotifier themeNotifier;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _toggleEnable = false;

  @override
  void initState() {
    _toggleEnable = widget.themeNotifier.value == Brightness.dark;
    super.initState();
  }

  toggleDisplayMode(int index) {
    widget.themeNotifier.toggleMode(index);
    if(index == 0) {
      _toggleEnable = false;
    } else {
      _toggleEnable = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        title: GradientText(widget.title, style: const TextStyle(fontSize: 22)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ToggleButtons(
              borderRadius: BorderRadius.circular(20),
                onPressed: (index) {
              toggleDisplayMode(index);
            }, isSelected: [!_toggleEnable, _toggleEnable],
            children: const [
              Icon(Icons.light_mode_outlined),
              Icon(Icons.dark_mode_outlined),
            ],),
          )
        ],
      ),
      body: const NewsFeedList(),
    );
  }
}