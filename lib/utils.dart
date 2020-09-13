
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'models/movies.dart';

createTextField(TextEditingController controller, String label, IconData icon,
        {bool isObscure}) =>
    TextFormField(
        
        cursorColor: Colors.white,
        controller: controller,
        obscureText: isObscure ?? false,
        decoration: InputDecoration(
          focusColor: Colors.white,
            focusedBorder: UnderlineInputBorder(borderSide:BorderSide(color: Colors.white)),
            labelText: label,
            prefixIcon: Icon(icon),
            border: UnderlineInputBorder(),
            hintText: ' $label'));

String getSimpleName(String str){
  String name='';
  str.split('').forEach((ch){
    if(name.length<18){
      name+=ch;
    }
  });
  return name;
}

emailValidator(String email) {
  if (email.contains('@')) {
    if (email.split('@')[1].contains('.')) {
      return true;
    }
  }
  return false;
}
bool isTimeOut(SocketException e) =>
    e.osError.message.contains('Connection timed out');

String getThumbnail(String url){
  String videoId=url.split('=')[1];
   String quality = ThumbnailQuality.standard;
  return 'https://i3.ytimg.com/vi/$videoId/$quality.jpg';
}
List<Movies> filterFavorite(List<Movies> movies,List<int> idFav){
  List<Movies> list=[];
  for(int i in idFav){
      for (Movies item in movies) {
        if(item.id==i){
          list.add(item);
        }
      }
  }
  return list;
}

bool isFavorite(Movies mov,List<int> idFav)=>idFav.contains(mov.id);