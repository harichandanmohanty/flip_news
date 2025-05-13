import 'dart:convert';
import 'package:flipnews/model/top_headlines.dart';
import 'package:flipnews/presentation/news_list_widget.dart';
import 'package:flipnews/presentation/widgets/gradient_text.dart';
import 'package:flipnews/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:transparent_image/transparent_image.dart';


class NewsFeedList extends StatefulWidget {
  const NewsFeedList({super.key});

  @override
  State<NewsFeedList> createState() => _NewsFeedListState();
}

class _NewsFeedListState extends State<NewsFeedList> {
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
    const baseUrl = 'https://newsapi.org/v2/';
    final topHeadlinesUrl =
        '${baseUrl}top-headlines?country=us${searchQuery != '' ? '&q=$searchQuery' : ''}${selectedCategory == Category.all.name ? '' : '&category=$selectedCategory'}&apiKey=${const String.fromEnvironment('auth_key')}';
    final Response response = await http.get(Uri.parse(topHeadlinesUrl));
    final decodedValue = jsonDecode(response.body);
    Map<String, dynamic>? data = decodedValue;
    debugPrint('$data');
    topHeadlines = TopHeadlines.fromJson(data ?? {});
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
                Container(
                  height: 55,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Container(
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black54,
                              blurRadius: 2,
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
                          onSubmitted: (value) {
                            searchQuery = value;
                            fetchHeadLines();
                            setState(() {
                              isSubmitted = true;
                            });
                          },
                          onTap: () {
                            setState(() {

                            });
                          },
                          focusNode: focusNode,
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search),
                           suffixIcon: IconButton(onPressed: () {
                             if(focusNode.hasFocus) focusNode.unfocus();
                             _textEditingController.clear();
                             WidgetsBinding.instance.addPostFrameCallback((_) {
                               Future.delayed(const Duration(milliseconds: 200), () {
                                 searchQuery = '';
                                 fetchHeadLines();
                                 setState(() {
                                   isSubmitted = false;
                                 });
                               });
                             });
                           },
                           icon: const Icon(Icons.close)),
                           contentPadding: const EdgeInsets.symmetric(vertical: 0),
                           border:  OutlineInputBorder(
                               borderRadius: BorderRadius.circular(20) ,
                               borderSide: const BorderSide(width: 10, style: BorderStyle.solid))
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: focusNode.hasFocus ? Container(): isSubmitted ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                    child: ListView(
                      children: topHeadlines.articles?.map((article) => Container(
                        width: double.infinity,
                        height: 80,
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                                      child: Text(article.title, overflow: TextOverflow.ellipsis, maxLines: 3, style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,),),
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),
                      )).toList() ?? [],
                    ),
                  ):Column(
                    children: [
                      Container(
                        height: 55,
                        padding: const EdgeInsets.only(left: 20),
                        child: ListView(
                            key: const PageStorageKey("Key"),
                            scrollDirection: Axis.horizontal,
                            children: Category.values.map<Widget>((category) => CategoryWidget(isSelected: selectedCategory == category.name,category , onTap: ({required Category category}) {
                              selectedCategory = category.name;
                              fetchHeadLines();
                            },)).toList()
                        ),
                      ),
                      isLoading
                          ? const Expanded(child: Center(child: CircularProgressIndicator()))
                          : NewsListWidget(topHeadlines: topHeadlines),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}

class CategoryWidget extends StatelessWidget {
  final Category categoryName;
  final void Function({required Category category}) onTap;
  final bool isSelected;
  const CategoryWidget(this.categoryName, {super.key, required this.onTap, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
          boxShadow: isSelected ? const [
            BoxShadow(
                color: Colors.black54,
                blurRadius: 3,
                spreadRadius: 0,
                offset: Offset(0, 0))
          ]: null,
          gradient: isSelected ? const LinearGradient(
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
          ) : null,
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
                    color: Colors.black54,
                    blurRadius: 0.5,
                    spreadRadius: 0.5,
                    offset: Offset(0, 0))
              ],
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: isSelected ? GradientText(categoryName.name, style: const TextStyle(fontSize: 18),): Text(categoryName.name, style: const TextStyle(fontSize: 18),),
          ),
        ),
      ),
    );
  }
}

