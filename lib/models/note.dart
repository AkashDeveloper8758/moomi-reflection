import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:moomi/helper/safe.dart';

class Note {
  final String id;
  final String title;
  final String description;
  final Map<String, String> tags;
  final DateTime date;
  final String reminderTime;
  Note({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.tags,
    @required this.date,
    @required this.reminderTime,
  });

  Map<String,dynamic> toMap(){
    return <String,dynamic>{
      Safe.id: id,
      Safe.title:title,
      Safe.description: description,
      Safe.tags: json.encode(tags),
      Safe.reminderTime: 'no reminder',
      Safe.date: date.toString()
    };
  }
}

class GenData {
  final String userName;
  final Map<String, String> tags;
  final String id;
  GenData({this.userName, this.tags,this.id});
  
  Map<String,String> toMap(){
    var toReturn =  <String,String>{
      Safe.generalId:id,
      Safe.userName:userName,
      Safe.tagsList:json.encode(tags),
    };
    //print("from NOTE => data before database: $toReturn");
    return toReturn;
  }
}
// GenData generalDataStore;
 GenData generalDataStore = GenData(
  id:Safe.uniqueGenId,
  tags: {

  },
  userName: 'friend',
);

 List<Note> userNotes = [
  // Note(
  //   id: '1',
  //   date: DateTime.now(),
  //   description:
  //       'this is my best day ever, i had spent my day with my grandparents in park,and like ia am playing with my friend like sam dam pan and folkeor with cruse and mission impossible',
  //   title: 'One of the best day',
  //   reminderTime: '18 mar, 8:00pm',
  //   tags: {
  //   '5': 'dangerous',
  //   '6': 'puffy',
  //   '7': 'beautiful',
  //   '8': 'lovely',
  // },
  // ),
];
