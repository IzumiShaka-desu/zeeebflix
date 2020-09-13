import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:zeebflix/constants.dart';
import 'package:zeebflix/models/movies.dart';
import 'package:zeebflix/service/network_service.dart';
import 'package:zeebflix/service/sharepref_service.dart';
import 'package:zeebflix/utils.dart';

class Details extends StatefulWidget {
  Details({this.movies, this.tag});
  final String tag;
  final Movies movies;
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  YoutubePlayerController _controller;
  bool isFavoriteMovies;
  checkFavorite() async {
    List<int> idFav = await NetworkService().getFavoriteId();
    print(await SFService().getEmail());
    setState(() {
      isFavoriteMovies = isFavorite(widget.movies, idFav);
    });
  }

  bool isOnProcess = false;
  GlobalKey<ScaffoldState> _sk = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    checkFavorite();
    _controller = YoutubePlayerController(
      initialVideoId: widget.movies.ytUrl.split('=')[1],
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    super.initState();
  }
    
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        key: _sk,
        backgroundColor: backgroundPrimaryDark,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(
                Icons.navigate_before,
                color: Colors.grey,
              ),
              onPressed: () => Navigator.of(context).pop()),
          elevation: 0,
          centerTitle: true,
          backgroundColor: backgroundPrimaryDark,
          actions: [
            IconButton(
                icon: (isFavoriteMovies ?? false)
                    ? Icon(Icons.favorite, color: primaryRed)
                    : Icon(
                        Icons.favorite_border,
                        color: Colors.grey,
                      ),
                onPressed: () async {
                  if(!isOnProcess){
                    setState(() {
                      isOnProcess=true;
                    });
                    (isFavoriteMovies)
                        ? await NetworkService()
                            .removeFavorite(widget.movies.id)
                        : await NetworkService().addFavorite(widget.movies.id);
                    checkFavorite();
                    showSnackbar((!isFavoriteMovies)
                        ? 'item has been added to the favorite movie'
                        : 'item has been removed from the favorite movie');
                  }
                  setState(() {
                    isOnProcess=false;
                  });
                })
          ],
          title: Container(
              width: size.width / 3,
              child: Image.asset('assets/images/zeeebflix.png')),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 200,
                  child: Hero(
                    tag: widget.tag,
                    child: Container(
                      child: YoutubePlayer(
                        controller: _controller,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.movies.title ?? '',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.movies.genres.join(", ") ?? '',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Center(
                    child: Transform.scale(
                      scale: 0.7,
                      child: RatingBar(
                        onRatingUpdate: (i) {},
                        initialRating: widget.movies.rating ?? 1,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        ignoreGestures: true,
                        itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Text('Year',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                            Text((widget.movies.year ?? 0).toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                          ],
                        )),
                    Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Text('Country',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                            Text(widget.movies.country ?? '',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                          ],
                        )),
                    Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Text('length',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                            Text(widget.movies.length ?? '',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ))
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(widget.movies.details ?? '',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  showSnackbar(String _msg) => _sk.currentState.showSnackBar(SnackBar(
      duration: Duration(seconds: 3),
      backgroundColor: backgroundLight,
      content: Material(
        type: MaterialType.transparency,
        child: Container(
          height: 50,
          child: Center(
              child: Row(
            children: [
              Expanded(
                child: Text(
                  _msg,
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.black),
                ),
              ),
            ],
          )),
        ),
      )));
}
