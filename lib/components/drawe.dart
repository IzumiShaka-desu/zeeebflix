import 'package:flutter/material.dart';
import 'package:zeebflix/constants.dart';
import 'package:zeebflix/models/movies.dart';
import 'package:zeebflix/screens/favorite.dart';
import 'package:zeebflix/screens/home.dart';
import 'package:zeebflix/screens/login_register.dart';
import 'package:zeebflix/service/sharepref_service.dart';

class DrawerCust extends StatelessWidget {
  DrawerCust({this.currentMenu});
  final int currentMenu;
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      padding: EdgeInsets.all(10),
      color: backgroundPrimaryDark,
      child: Column(children: [
        DrawerHeader(
          child: Column(
            children: [
              Transform.scale(scale: 2, child: CircleAvatar()),
              SizedBox(
                height: 40,
              ),
              FutureBuilder(
                  future: SFService().getLoginDetails(),
                  builder: (ctx, snapshot) => (snapshot.hasData)
                      ? Row(
                          children: [
                            Text(
                              'Welcome back ${snapshot.data['name']}',
                              style: TextStyle(color: backgroundLight),
                            ),
                          ],
                        )
                      : Container())
            ],
          ),
        ),
        Container(
          height: 50,
          child: InkWell(
            onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Home())),
            child: Center(
              child: Container(
                  color: backgroundPrimaryDark,
                  child: Row(
                    children: [
                      Icon(
                        Icons.home,
                        color:
                            (currentMenu == 0) ? primaryRed : backgroundLight,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Home',
                        style: TextStyle(
                            color: (currentMenu == 0)
                                ? primaryRed
                                : backgroundLight,
                            fontSize: 16),
                      )
                    ],
                  )),
            ),
          ),
        ),
        Container(
          height: 50,
          child: InkWell(
            onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Favorite())),
            child: Center(
              child: Container(
                  color: backgroundPrimaryDark,
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color:
                            (currentMenu == 1) ? primaryRed : backgroundLight,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'favorite',
                        style: TextStyle(
                            color: (currentMenu == 1)
                                ? primaryRed
                                : backgroundLight,
                            fontSize: 16),
                      )
                    ],
                  )),
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              splashColor: Colors.grey[50],
              onTap: () async{
                  await SFService().removeSaveLogin();
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx)=>LoginAndRegister()));
              },
              child: Container(
                padding: EdgeInsets.all(10),
                height: 50,
                decoration: BoxDecoration(
                    border: Border.symmetric(
                        vertical: BorderSide(color: Colors.grey[50]))),
                child: Center(
                  child: Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Logout',
                        style: TextStyle(color: Colors.redAccent, fontSize: 16),
                      ),
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.redAccent,
                      ),
                    ],
                  )),
                ),
              ),
            ),
          ),
        )
      ]),
    ));
  }
}
