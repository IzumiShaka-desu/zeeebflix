import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:zeebflix/models/movies.dart';
import 'package:zeebflix/service/sharepref_service.dart';

class NetworkService{
  var client=http.Client();
  String basePath="https://zeeeb.000webhostapp.com/";
  Future registerUser(String fullname, String _email, String password) async {
    String url = basePath + "serviceregister.php";
    var response = await client.post(url,
        body: {'email': _email, 'fullname': fullname, 'password': password});
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body) as Map;
      return result;
    }
    return {'message': "register gagal", 'result': false};
  }

  Future loginUser(String _email, String password) async {
    String url = basePath + "servicelogin.php";
    var response =
        await client.post(url, body: {'email': _email, 'password': password});
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body) as Map;
      (result['result'] == 1)
          ? result['result'] = true
          : result['result'] = false;
      return result;
    }
    return {'message': "login gagal", 'result': false};
  }
  Future<List<int>> getFavoriteId()async{
    List<int> list=[];
    String email=await SFService().getEmail();
    String url = basePath + "getfavorites.php?email=$email";
    var response=await client.get(url);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body) as Map;
      List res=result['movies'] as List;
      if(result['result'] == 1){
          res.forEach((element) {
            list.add(int.parse(element['id']));
          });
      }
    }
    return list;

  }
  Future<List<Movies>> getReccomend()async{

    List<Movies> list=[];
    String url = basePath + "getrecommend.php";
    var response=await client.get(url);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body) as Map;
      List res=result['movies'] as List;
      if(result['result'] == 1){
          res.forEach((value) {
            list.add(Movies.fromMap(value));
          });
      }
    }
    return list;

  }
  Future<List<Movies>> getNewRelease()async{

    List<Movies> list=[];
    String url = basePath + "getnewrelease.php";
    var response=await client.get(url);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body) as Map;
      List res=result['movies'] as List;
      if(result['result'] == 1){
          res.forEach((value) {
            list.add(Movies.fromMap(value));
          });
      }
    }
    return list;

  }

  Future<bool> addFavorite(int id) async {
    String email=await SFService().getEmail();
    String url = basePath + "addfavorite.php";
    var response =
        await client.post(url, body: {'email': email, 'id': id.toString()});
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body) as Map;
      (result['result'] == 1)
          ? result['result'] = true
          : result['result'] = false;
      return result['result'];
    }
    return false;
  }
  Future<bool> removeFavorite(int id) async {
    String email=await SFService().getEmail();
    String url = basePath + "removefavorite.php";
    var response =
        await client.post(url, body: {'email': email, 'id': id.toString()});
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body) as Map;
      (result['result'] == 1)
          ? result['result'] = true
          : result['result'] = false;
      return result['result'];
    }
    return false;
  }
  
}