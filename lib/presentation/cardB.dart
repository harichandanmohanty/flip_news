import 'dart:math';
import 'package:flipnews/model/top_headlines.dart';
import 'package:flipnews/presentation/news_details.dart';
import 'package:flipnews/presentation/news_feed.dart';
import 'package:flutter/material.dart';

class CardB extends StatefulWidget {
  const CardB({
    super.key,
    required this.topHeadlines,
  });

  final TopHeadlines topHeadlines;

  @override
  State<CardB> createState() => _CardBState();
}

class _CardBState extends State<CardB> with SingleTickerProviderStateMixin {
  int? currentIndex;
  double dragPosition = 0;
  bool isBack = false;
  bool swipeUp = false;

  late AnimationController _controller;
  late Animation<double> animation;

  @override
  void initState() {
    _controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _controller.addListener(() {
      setState(() {
        dragPosition = animation.value;
        setSide();
      });
    });
    if (widget.topHeadlines.articles?.isNotEmpty ?? false) {
      currentIndex = 0;
    }
    super.initState();
  }

  update(double dragPosition) {
    if(dragPosition.abs() >= 180 && dragPosition.abs() < 360) {
      if(!isBack) {
        updateIndex(swipeUp: swipeUp);
      }
      isBack = true;
    } else if(dragPosition.abs() >= 0 && dragPosition.abs() < 180) {
      isBack = false;
    }
  }

  updateIndex({required bool swipeUp}) {
    if (swipeUp && currentIndex! < widget.topHeadlines.articles!.length- 1) {
      currentIndex = currentIndex! + 1;
    } else if(!swipeUp && currentIndex! >= 1) {
      currentIndex = currentIndex! - 1;
    }
  }
  setSide() {
    if(dragPosition.abs() >= 360 ) {
      if(dragPosition!= 0) {
        dragPosition = 0;
      }
    }
    if((currentIndex! >= widget.topHeadlines.articles!.length- 1 && swipeUp)
        || currentIndex! < 1 && !swipeUp) {
      dragPosition = 0;
      isBack = false;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final angle = (dragPosition/360) * pi;
    update(dragPosition);
    return currentIndex != null ?GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WebViewApp(url: widget.topHeadlines.articles![currentIndex!].url,);
        }));
      },
      onVerticalDragEnd: (details) {
        double end =  dragPosition > 0 ? 360: -360;
        animation = Tween<double>(
            begin: dragPosition,
            end: end).animate(_controller);
        _controller.forward(from: 0);
      },
      onVerticalDragUpdate: (details) {
        setState(() {
          dragPosition += details.delta.dy;
          if(details.delta.dy > 0) {
            swipeUp = false;
          } else if(details.delta.dy < 0) {
            swipeUp = true;
          }
          setSide();
        });
      },
      child: Container(
        transform: Matrix4.identity()..setEntry(3, 2, 0.001)..rotateX(angle),
        //alignment: Alignment.center,
        transformAlignment:  AlignmentDirectional.center,
        child: Transform.flip(
          flipY: isBack,
          child: NewsFeed(
            title: widget.topHeadlines.articles?[currentIndex!].title ?? '',
            description: widget.topHeadlines.articles?[currentIndex!].description ?? '',
            urlToImage: widget.topHeadlines.articles?[currentIndex!].urlToImage,
          ),
        ),
      ),
    ): Container();
  }
}