
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zeebflix/constants.dart';
import 'package:zeebflix/screens/home.dart';
import 'package:zeebflix/screens/login_register.dart';
import 'package:zeebflix/service/sharepref_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isAnimate=false;
  setFull() {
    setState(() {
     isAnimate=true;
    });
  }

  @override
  void initState() {
    super.initState();
    
    delayMethod(2940, setFull);
  }

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Positioned.fill(
            child: Container(
              color: backgroundPrimaryDark,
          child: Center(
            child: Wrap(
              children: [
                Container(
                  padding: EdgeInsets.all(30),
                  child: Image.asset('assets/images/zeeebflix.png')),
              ],
            ),)
          ),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 200),
          top: (isAnimate)?-height:-2,
          left: (isAnimate)?-width:-2,
                  child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            
            decoration: BoxDecoration(color:primaryRed,shape: BoxShape.circle),
            height: (isAnimate)?height*3:0,
            width: (isAnimate)?width*3:0,
            onEnd: ()=>gotoHome(),
          ),
        )
      ],
    );
  }
  Future delayMethod(int delayMillis,Function method)async{
      return Timer(Duration(milliseconds: delayMillis),method);
}
  void gotoHome() async{
    Widget target;
    bool isLogin=await SFService().isLogin();
   (isLogin)?target=Home():target=LoginAndRegister();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => target));
  }
}
