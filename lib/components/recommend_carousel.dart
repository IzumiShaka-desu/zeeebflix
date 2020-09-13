import 'dart:async';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:zeebflix/constants.dart';
import 'package:zeebflix/models/movies.dart';
import 'package:zeebflix/screens/details.dart';
import 'package:zeebflix/utils.dart';

class RecommendedCarousel extends StatefulWidget {
  RecommendedCarousel({@required this.movies, @required this.width});
  final double width;
  final List<Movies> movies;
  @override
  _RecommendedCarouselState createState() => _RecommendedCarouselState();
}

class _RecommendedCarouselState extends State<RecommendedCarousel> {
  PageController _pageController;
  double currentPage = 0;

  @override
  void initState() {
    _pageController=PageController(initialPage: 0);
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page;
      });
    });
    initializeTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          String tag = "rec " + widget.movies[currentPage.floor()].title;
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => Details(
                    movies: widget.movies[currentPage.floor()],
                    tag: tag,
                  )));
        },
        child: Container(
          child: Stack(
            children: [
              SizedBox(
                height: 200,
                child: PageView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    controller: _pageController,
                    itemCount: widget.movies.length,
                    itemBuilder: (ctx, index) => AnimatedContainer(
                          duration: Duration(milliseconds: 250),
                          padding: EdgeInsets.all(10),
                          transform: Matrix4.identity()
                            ..scale(
                                (index == currentPage) ? 1.toDouble() : 0.7),
                          width: widget.width / 2,
                          child: Stack(children: [
                            Positioned.fill(
                                child: Hero(
                                    tag: "rec " + widget.movies[index].title,
                                    child: Container(
                                      child: Image.network(
                                          getThumbnail(widget.movies[index].ytUrl)),
                                    ))),
                          ]),
                        )),
              ),
              Positioned(
                left: 20,
                bottom: 5.0,
                child: Text(
                  '${widget.movies[currentPage.floor()].title}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Positioned(
                  right: 10,
                  bottom: 10,
                  child: DotsIndicator(
                    dotsCount: widget.movies.length,
                    position: currentPage,
                    decorator: DotsDecorator(
                      activeColor: primaryRed,
                      size: const Size.square(9.0),
                      activeSize: const Size(18.0, 9.0),
                      activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void initializeTimer() async {
    Timer.periodic(Duration(seconds: 3), (timer) {
      if (currentPage < widget.movies.length - 1) {
        _pageController.nextPage(
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      } else {
        _pageController.animateToPage(0,
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    });
  }
}
