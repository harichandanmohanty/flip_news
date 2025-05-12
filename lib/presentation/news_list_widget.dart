import 'package:flipnews/model/top_headlines.dart';
import 'package:flipnews/presentation/cardB.dart';
import 'package:flutter/material.dart';

class NewsListWidget extends StatelessWidget {
  const NewsListWidget({
    super.key,
    required this.topHeadlines,
  });

  final TopHeadlines topHeadlines;

  @override
  Widget build(BuildContext context) {
    return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: CardB(
                  topHeadlines: topHeadlines,
                ),
              ),
            ],
          );
  }
}
