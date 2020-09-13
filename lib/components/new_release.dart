import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:zeebflix/constants.dart';
import 'package:zeebflix/models/movies.dart';
import 'package:zeebflix/screens/details.dart';
import 'package:zeebflix/utils.dart';

class NewRelease extends StatefulWidget {
  NewRelease({@required this.movies});
  final List<Movies> movies;
  @override
  _NewReleaseState createState() => _NewReleaseState();
}

class _NewReleaseState extends State<NewRelease> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: widget.movies.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index) => Container(
                margin: EdgeInsets.only(left: 5, right: 10),
                child: Card(
                  color: backgroundPrimaryDark,
                  child: InkWell(
                    onTap: () {
                      String tag = widget.movies[index].title;
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => Details(
                                movies: widget.movies[index],
                                tag: tag,
                              )));
                    },
                    child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              alignment: Alignment.topCenter,
                              fit: BoxFit.contain,
                              
                                image: NetworkImage(getThumbnail(widget.movies[index].ytUrl)))),
                        child: Stack(
                          children: [
                            Positioned(
                                bottom: -5,
                                child: Container(
                                  width: 200,
                                  padding: EdgeInsets.only(left: 5, bottom: 5),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.vertical(bottom:Radius.circular(20))),
                                  
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(child: Center(child: Text(widget.movies[index].title,style: TextStyle(color:backgroundLight),))),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                                                              child: Container(
                                          height: 35,
                                          child: Transform.scale(
                                            scale: 0.4,
                                            child: RatingBar(
                                              onRatingUpdate: (i) {},
                                              initialRating:
                                                  widget.movies[index].rating ??
                                                      1,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              ignoreGestures: true,
                                              itemPadding: EdgeInsets.symmetric(
                                                  horizontal: 0),
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        )),
                  ),
                ),
              )),
    );
  }
}
