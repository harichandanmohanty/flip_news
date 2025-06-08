import 'package:flipnews/data/model/top_headlines.dart';
import 'package:flipnews/data/news_api_client.dart';
import 'package:flipnews/presentation/flip_board/view/flip_board.dart';
import 'package:flipnews/presentation/search/view/search_results.dart';
import 'package:flipnews/presentation/search/view/search_widget.dart';
import 'package:flipnews/utils/util.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TopHeadlines topHeadlines = TopHeadlines.fromJson({});
  bool isLoading = false;
  String selectedCategory = Category.all.name;
  String searchQuery = '';
  bool isSubmitted = false;
  late FocusNode focusNode;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    focusNode = FocusNode();
    _textEditingController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fetchHeadLines();
    });
    super.initState();
  }

  @override
  dispose() {
    focusNode.dispose();
    super.dispose();
  }

  Future<void> fetchHeadLines() async {
    setState(() {
      isLoading = true;
    });
    topHeadlines =
        await getTopHeadLines(selectedCategory: selectedCategory, searchQuery: searchQuery);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          SearchWidget(
            onSubmitted: (value) {
              searchQuery = value;
              fetchHeadLines();
              setState(() {
                isSubmitted = true;
              });
            },
            focusNode: focusNode,
            textEditingController: _textEditingController,
            onTap: () {
              setState(() {});
            },
            onClear: () {
              if (focusNode.hasFocus) focusNode.unfocus();
              _textEditingController.clear();
              WidgetsBinding.instance.addPostFrameCallback(
                (_) {
                  Future.delayed(
                    const Duration(milliseconds: 200),
                    () {
                      searchQuery = '';
                      fetchHeadLines();
                      setState(
                        () {
                          isSubmitted = false;
                        },
                      );
                    },
                  );
                },
              );
            },
          ),
          Expanded(
            child: focusNode.hasFocus
                ? Container()
                : isSubmitted
                    ? SearchResults(
                        topHeadlines: topHeadlines,
                      )
                    : FlipBoard(
                        isLoading: isLoading,
                        topHeadlines: topHeadlines,
                        selectedCategory: selectedCategory,
                        setCategory: ({required Category category}) {
                          selectedCategory = category.name;
                          fetchHeadLines();
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
