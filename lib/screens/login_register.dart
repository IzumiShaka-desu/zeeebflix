import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:zeebflix/constants.dart';
import 'package:zeebflix/service/network_service.dart';
import 'package:zeebflix/service/sharepref_service.dart';

import '../utils.dart';
import 'home.dart';

class LoginAndRegister extends StatefulWidget {
  @override
  _LoginAndRegisterState createState() => _LoginAndRegisterState();
}

class _LoginAndRegisterState extends State<LoginAndRegister> {
  Map<String, TextEditingController> controller = {
    'emailLogin': TextEditingController(),
    'emailRegister': TextEditingController(),
    'fullname': TextEditingController(),
    'passwordLogin': TextEditingController(),
    'confirmPassword': TextEditingController(),
    'password': TextEditingController(),
  };
  GlobalKey<ScaffoldState> _sk = GlobalKey<ScaffoldState>();
  setControllerEmpty() {
    for (String i in controller.keys) {
      controller[i].text = '';
    }
  }

  bool isExpanded = false;
  bool isSuccessfull = false;
  PageController _pageController = PageController();
  double currentPageValue = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPageValue = _pageController.page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _sk,
      backgroundColor: backgroundPrimaryDark,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                width: size.width,
                height: size.height,
                child: Column(children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.bounceInOut,
                    margin: EdgeInsets.only(top: (isExpanded) ? 30 : 100),
                    padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                    height: 130,
                    child: Center(
                        child: Image.asset('assets/images/zeeebflix.png')),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 100),
                    opacity: (isExpanded) ? 0.0 : 1.0,
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                              child: InkWell(
                            onTap: () {
                              _pageController.jumpToPage(0);
                              setState(() {
                                isExpanded = true;
                              });
                            },
                            child: AnimatedContainer(
                                decoration: BoxDecoration(
                                    color: backgroundLight,
                                    borderRadius: BorderRadius.circular(15)),
                                height: 50,
                                width: size.width * 0.6,
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.input,
                                        color: primaryRed,
                                        size: 20,
                                      ),
                                      SizedBox(width: 10),
                                      Text('Login',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: primaryRed,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                                curve: Curves.bounceOut,
                                duration: Duration(milliseconds: 250)),
                          )),
                      
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text('OR',
                        style: TextStyle(
                            fontSize: 18,
                            color: primaryRed,
                            fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      child: InkWell(
                    onTap: () {
                      _pageController.jumpToPage(1);
                      setState(() {
                        isExpanded = true;
                      });
                    },
                    child: AnimatedContainer(
                        decoration: BoxDecoration(
                            color: backgroundLight,
                            borderRadius: BorderRadius.circular(15)),
                        height: 50,
                        width: size.width * 0.6,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.mode_edit,
                                color: primaryRed,
                                size: 20,
                              ),
                              SizedBox(width: 10),
                              Text('Register',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: primaryRed,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        curve: Curves.bounceOut,
                        duration: Duration(milliseconds: 250)),
                  )),  ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            AnimatedPositioned(
                top: (!isExpanded) ? size.height + 100 : 140,
                curve: Curves.bounceInOut,
                child: Container(
                  height: size.height,
                  width: size.width,
                  child: Column(
                    children: [
                      Container(
                        height: 30,
                        child: DotsIndicator(
                            decorator: DotsDecorator(activeColor: primaryRed),
                            dotsCount: 2,
                            position: currentPageValue),
                      ),
                      Expanded(
                          child: PageView.builder(
                              controller: _pageController,
                              itemCount: 2,
                              physics: (isLoading)
                                  ? NeverScrollableScrollPhysics()
                                  : AlwaysScrollableScrollPhysics(),
                              itemBuilder: (ctx, index) {
                                return Container(
                                  color: primaryRed.withAlpha(150),
                                  child: SingleChildScrollView(
                                    child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(15),
                                        child: (isLoading)
                                            ? Container(
                                                child: Center(
                                                child: SizedBox(
                                                    height: 50,
                                                    width: 50,
                                                    child:
                                                        CircularProgressIndicator()),
                                              ))
                                            : (index == 0)
                                                ? Column(children: [
                                                    SizedBox(height: 20),
                                                    Text('Login',
                                                        style: TextStyle(
                                                            color:
                                                                backgroundLight,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)),
                                                    SizedBox(height: 10),
                                                    Container(
                                                        width: size.width * 0.7,
                                                        child: createTextField(
                                                            controller[
                                                                'emailLogin'],
                                                            "email",
                                                            Icons
                                                                .alternate_email)),
                                                    SizedBox(height: 15),
                                                    Container(
                                                        width: size.width * 0.7,
                                                        child: createTextField(
                                                            controller[
                                                                'passwordLogin'],
                                                            "password",
                                                            Icons.lock_outline,
                                                            isObscure: true)),
                                                    SizedBox(height: 20),
                                                    Material(
                                                      type: MaterialType
                                                          .transparency,
                                                      child: InkWell(
                                                          onTap: () => exectLogin(
                                                              controller['emailLogin']
                                                                  .text,
                                                              controller['passwordLogin']
                                                                  .text),
                                                          child:
                                                              AnimatedContainer(
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                          backgroundLight,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15)),
                                                                  height: 50,
                                                                  width: size.width *
                                                                      0.6,
                                                                  child: Center(
                                                                    child: Text(
                                                                        'Login',
                                                                        style: TextStyle(
                                                                            color:
                                                                                primaryRed,
                                                                            fontWeight:
                                                                                FontWeight.w600)),
                                                                  ),
                                                                  curve: Curves
                                                                      .bounceOut,
                                                                  transform: Matrix4
                                                                      .identity()
                                                                    ..scale((currentPageValue ==
                                                                            index
                                                                                .toInt())
                                                                        ? 1.0
                                                                        : 0.00000001),
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          250))),
                                                    )
                                                  ])
                                                : Column(children: [
                                                    SizedBox(height: 10),
                                                    Text('Register',
                                                        style: TextStyle(
                                                            color:
                                                                backgroundLight,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)),
                                                    SizedBox(height: 10),
                                                    Container(
                                                        width: size.width * 0.7,
                                                        child: createTextField(
                                                            controller[
                                                                'fullname'],
                                                            "nama",
                                                            Icons
                                                                .account_circle)),
                                                    Container(
                                                        width: size.width * 0.7,
                                                        child: createTextField(
                                                            controller[
                                                                'emailRegister'],
                                                            "email",
                                                            Icons
                                                                .alternate_email)),
                                                    Container(
                                                        width: size.width * 0.7,
                                                        child: createTextField(
                                                            controller[
                                                                'password'],
                                                            "password",
                                                            Icons.lock_outline,
                                                            isObscure: true)),
                                                    Container(
                                                        width: size.width * 0.7,
                                                        child: createTextField(
                                                            controller[
                                                                'confirmPassword'],
                                                            "konfirmasi password",
                                                            Icons.lock_outline,
                                                            isObscure: true)),
                                                    SizedBox(height: 20),
                                                    Center(
                                                      child: Material(
                                                        type: MaterialType
                                                            .transparency,
                                                        child: InkWell(
                                                            onTap: () => (!isLoading)
                                                                ? exectRegister(
                                                                    controller['fullname']
                                                                        .text,
                                                                    controller['password']
                                                                        .text,
                                                                    controller['confirmPassword']
                                                                        .text,
                                                                    controller['emailRegister']
                                                                        .text)
                                                                : () {},
                                                            child:
                                                                AnimatedContainer(
                                                                    decoration: BoxDecoration(
                                                                        color:
                                                                            backgroundLight,
                                                                        borderRadius: BorderRadius.circular(
                                                                            15)),
                                                                    height: 50,
                                                                    width:
                                                                        size.width *
                                                                            0.6,
                                                                    child:
                                                                        Center(
                                                                      child: Text(
                                                                          'Register',
                                                                          style: TextStyle(
                                                                              color: primaryRed,
                                                                              fontWeight: FontWeight.w600)),
                                                                    ),
                                                                    curve: Curves
                                                                        .bounceOut,
                                                                    transform: Matrix4
                                                                        .identity()
                                                                      ..scale((currentPageValue == index.toInt())
                                                                          ? 1.0
                                                                          : 0.00000001),
                                                                    duration: Duration(
                                                                        milliseconds: 250))),
                                                      ),
                                                    )
                                                  ])),
                                  ),
                                );
                              }))
                    ],
                  ),
                ),
                duration: Duration(milliseconds: 300))
          ],
        ),
      ),
    );
  }

  exectLogin(String email, String password) async {
    setState(() {
      isLoading = true;
    });
    var result;
    String msg = '', timeout = '';
    var service = NetworkService();
    if (email == '' || password == '') {
      showSnackbar('form tidak boleh kosong');
    } else if (!emailValidator(email)) {
      showSnackbar('email tidak valid');
    } else {
      try {
        result = await service.loginUser(email, password);
        msg = result['message'];
      } on SocketException catch (e) {
        if (isTimeOut(e)) timeout = " koneksi terputus";
      } catch (e) {
        debugPrint(e.toString());
      }
      showSnackbar(msg + timeout);
    }
    setState(() {
      isLoading = false;
    });
    if (result['result']) {
      SFService().saveLoginDetails(email, result['fnameData']);
      goToDashboard();
    }
  }

  exectRegister(String fullname, String password, String confirmpassword,
      String email) async {
    setState(() {
      isLoading = true;
    });
    var service = NetworkService();
    if (fullname.isEmpty ||
        password.isEmpty ||
        confirmpassword.isEmpty ||
        email.isEmpty) {
      showSnackbar('form tidak boleh kosong');
    } else if (!emailValidator(email)) {
      showSnackbar('email tidak valid');
    } else if (password != confirmpassword) {
      showSnackbar('password dan konfirmasi password tidak sesuai');
    } else {
      var result;
      String msg = '', timeout = '';
      try {
        result = await service.registerUser(fullname, email, password);
        msg = result['message'];
      } on SocketException catch (e) {
        if (isTimeOut(e)) timeout = " koneksi terputus";
      } catch (e) {
        debugPrint(e.toString());
      }
      if (result['result'] == 1) {
        msg += ' silahkan login';
        setControllerEmpty();
      }
      showSnackbar(msg + timeout);
    }
    setState(() {
      isLoading = false;
    });
  }

  goToDashboard() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
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
