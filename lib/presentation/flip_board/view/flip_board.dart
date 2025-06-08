import 'package:flipnews/data/model/top_headlines.dart';
import 'package:flipnews/presentation/widgets/flip_card.dart';
import 'package:flipnews/presentation/widgets/gradient_text.dart';
import 'package:flipnews/utils/util.dart';
import 'package:flutter/material.dart';

class FlipBoard extends StatefulWidget {
  const FlipBoard({super.key, required this.isLoading, required this.topHeadlines, required this.selectedCategory, required this.setCategory});

  final bool isLoading;
  final TopHeadlines topHeadlines;
  final String selectedCategory;
  final Function({required Category category}) setCategory;

  @override
  State<FlipBoard> createState() => _FlipBoardState();
}

class _FlipBoardState extends State<FlipBoard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 55,
          padding: const EdgeInsets.only(left: 20),
          child: ListView(
              key: const PageStorageKey("Key"),
              scrollDirection: Axis.horizontal,
              children: Category.values
                  .map<Widget>((category) => CategoryWidget(
                isSelected: widget.selectedCategory == category.name,
                category,
                onTap: widget.setCategory,
              ))
                  .toList()),
        ),
        widget.isLoading
            ? const Expanded(child: Center(child: CircularProgressIndicator()))
            : FlipCard(topHeadlines: widget.topHeadlines),
      ],
    );
  }
}


class CategoryWidget extends StatelessWidget {
  final Category categoryName;
  final void Function({required Category category}) onTap;
  final bool isSelected;
  const CategoryWidget(this.categoryName,
      {super.key, required this.onTap, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
          boxShadow: isSelected
              ? const [
            BoxShadow(
                color: Colors.black54, blurRadius: 3, spreadRadius: 0, offset: Offset(0, 0))
          ]
              : null,
          gradient: isSelected
              ? const LinearGradient(
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
          )
              : null,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: InkWell(
          onTap: () => onTap(category: categoryName),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: const [
                BoxShadow(
                    color: Colors.black54, blurRadius: 0.5, spreadRadius: 0.5, offset: Offset(0, 0))
              ],
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: isSelected
                ? GradientText(
              categoryName.name,
              style: const TextStyle(fontSize: 18),
            )
                : Text(
              categoryName.name,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
