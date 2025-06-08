import 'package:flipnews/data/model/top_headlines.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key, required this.topHeadlines});

  final TopHeadlines topHeadlines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: ListView(
        children: topHeadlines.articles
            ?.map((article) => Container(
          width: double.infinity,
          height: 80,
          margin: const EdgeInsets.symmetric(
              vertical: 5, horizontal: 5),
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 1,
                    spreadRadius: 0,
                    offset: Offset(0, 0))
              ],
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 251, 108, 173),
                  Color.fromARGB(255, 209, 106, 199),
                  Color.fromARGB(255, 190, 105, 210),
                  Color.fromARGB(255, 149, 103, 235),
                  Color.fromARGB(255, 115, 102, 255),
                  Color.fromARGB(255, 115, 102, 255),
                  Color.fromARGB(255, 115, 102, 255)
                ], // Gradient colors
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black54,
                      blurRadius: 0.5,
                      spreadRadius: 0.5,
                      offset: Offset(0, 0))
                ],
                borderRadius:
                const BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: article.urlToImage ?? '',
                            height: 60,
                            fit: BoxFit.fitHeight,
                            imageErrorBuilder: (ctx, obj, _) {
                              return FittedBox(
                                fit: BoxFit.fill,
                                child: Container(
                                  color: Colors.white38,
                                ),
                              );
                            },
                          )),
                    ),
                  ),
                  Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          article.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ))
            .toList() ??
            [],
      ),
    );
  }
}
