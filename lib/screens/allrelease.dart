import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:zeebflix/models/movies.dart';
import 'package:zeebflix/service/network_service.dart';

import '../constants.dart';
import '../utils.dart';
import 'details.dart';

class AllNewRelease extends StatefulWidget {
  @override
  _NewReleaseState createState() => _NewReleaseState();
}

class _NewReleaseState extends State<AllNewRelease> {
  final GlobalKey<ScaffoldState> _sk = GlobalKey<ScaffoldState>();
  List<Movies> movies = [];

  @override
  void initState() {
    loadMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _sk,
      backgroundColor: backgroundPrimaryDark,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: backgroundPrimaryDark,
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              onPressed: () {})
        ],
        leading: Container(),
        
        title: Container(
            width: size.width / 3,
            child: Image.asset('assets/images/zeeebflix.png')),
      ),
      body: SafeArea(
          child: Container(
              child: (movies.length < 1)
                  ? Center(
                      child: SizedBox(height:50,width: 50,child: CircularProgressIndicator(),)
                    )
                  : Column(children: [
                      Container(
                        height: 50,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                              child: Text(
                                'New Releases Movie',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                      Flexible(
                          child: GridView.builder(
                              itemCount: movies.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemBuilder: (ctx, index) => Container(
                                    height: 200,
                                    child: Card(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          String tag = movies[index].title;
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (ctx) => Details(
                                                        movies: movies[index],
                                                        tag: tag,
                                                      )));
                                        },
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        fit: BoxFit.contain,
                                                        image: NetworkImage(
                                                            getThumbnail(
                                                                movies[index]
                                                                    .ytUrl)))),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Center(
                                                        child: Text(
                                                  movies[index].title,
                                                  style: TextStyle(
                                                      color: backgroundLight),
                                                ))),
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
                                                        movies[index].rating ??
                                                            1,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    ignoreGestures: true,
                                                    itemPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 0),
                                                    itemBuilder: (context, _) =>
                                                        Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )))
                    ]))),
    );
  }

  void loadMovies() async {
    var service = NetworkService();
    List<Movies> list = await service.getNewRelease();
    setState(() {
      movies = list;
    });
  }
}
