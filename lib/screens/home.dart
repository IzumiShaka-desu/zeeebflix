import 'package:flutter/material.dart';
import 'package:zeebflix/components/drawe.dart';
import 'package:zeebflix/components/new_release.dart';
import 'package:zeebflix/components/recommend_carousel.dart';
import 'package:zeebflix/constants.dart';
import 'package:zeebflix/models/movies.dart';
import 'package:zeebflix/service/network_service.dart';
import 'package:zeebflix/utils.dart';

import 'allrelease.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _sk = GlobalKey<ScaffoldState>();

  bool isLoading = true;
  List<Movies> newRelease = [];
  List<Movies> recommend = [];
  List<int> favorite = [];
  List<Movies> favMovies=[];
  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _sk,
      drawer: DrawerCust(currentMenu: 0,),
      endDrawerEnableOpenDragGesture: true,
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
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.grey),
          onPressed: () => _sk.currentState.openDrawer(),
        ),
        title: Container(
            width: size.width / 3,
            child: Image.asset('assets/images/zeeebflix.png')),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
                  child: (isLoading)?Container(
                    padding: EdgeInsets.all(10),
                    child: Center(child: SizedBox(
                      width:50,height: 50,
                      child: CircularProgressIndicator()),),
                  ):Column(children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
              child: Text(
                'Most Views',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
        SizedBox(
            width: size.width,
            height: 225,
            child: RecommendedCarousel(width: size.width, movies: recommend)),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                child: Text(
                  'New Releases',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                )),
            InkWell(
              onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>AllNewRelease())),
                          child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 5, 10, 5),
                  child: Text(
                    'See All',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  )),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
            height: 200, width: size.width, child: NewRelease(movies: newRelease.take(6).toList()))
      ])))),
    );
  }

  void loadData() async {
    var service=NetworkService();
    List<Movies> _newRelease = await service.getNewRelease();
    List<Movies> _recommend = await service.getReccomend();
    List<int> _favorite = await service.getFavoriteId();
    setState(() {
      
      newRelease=_newRelease;
      recommend=_recommend;
      favorite=_favorite;
      favMovies= filterFavorite(_newRelease, _favorite);
      isLoading=false;
    });
  }
}
