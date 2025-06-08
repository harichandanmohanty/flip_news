
import 'package:flipnews/presentation/widgets/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class NewsFeed extends StatelessWidget {
  const NewsFeed({super.key, this.title, this.description, this.urlToImage});

  final String? title;
  final String? description;
  final String? urlToImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 600,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black54,
                blurRadius: 3,
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
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        margin: const EdgeInsets.all(3),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 0.5,
                  spreadRadius: 0.5,
                  offset: Offset(0, 0))
            ],
            borderRadius: const BorderRadius.all(Radius.circular(18)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (urlToImage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: urlToImage ?? "",
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (ctx, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: 300, // Match the image height
                            color: Colors.grey[300], // Placeholder background
                            child: const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
                          );
                        },
                      )),
                ),
              GradientText(
                title ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  //overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: Text(
                  description ?? '',
                  softWrap: true,
                  maxLines: null,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}