import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final Function(String) onSubmitted;
  final VoidCallback onTap;
  final VoidCallback onClear;
  const SearchWidget({super.key, required this.onSubmitted, required this.focusNode, required this.textEditingController, required this.onTap, required this.onClear});


  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black54, blurRadius: 2, spreadRadius: 0, offset: Offset(0, 0))
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
          margin: const EdgeInsets.all(1),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: const [
                BoxShadow(
                    color: Colors.black54,
                    blurRadius: 0,
                    spreadRadius: 0,
                    offset: Offset(0, 0))
              ],
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: TextField(
              onSubmitted: (value) => widget.onSubmitted(value),
              onTap: widget.onTap,
              focusNode: widget.focusNode,
              controller: widget.textEditingController,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                      onPressed: widget.onClear,
                      icon: const Icon(Icons.close)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(width: 10, style: BorderStyle.solid))),
            ),
          ),
        ),
      ),
    );
  }
}
