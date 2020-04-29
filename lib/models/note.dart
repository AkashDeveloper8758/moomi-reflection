import 'package:flutter/cupertino.dart';

class Note {
  final String id;
  final String title;
  final String description;
  final List<String> tags;
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
}

class GenData {
  final String userName;
  final List<String> tags;
  GenData({this.userName, this.tags});
}

final GenData generalData = GenData(tags: [
  'All',
  'good',
  'bad news',
  'cool guy',
  'top class',
  'fight day',
  'relax day',
  'sad day'
], userName: 'akash');

/*
final List<Note> userNotes = [
  Note(
    id: '1',
    date: DateTime.now(),
    description:
        'this is my best day ever, i had spent my day with my grandparents in park,and like ia am playing with my friend like sam dam pan and folkeor with cruse and mission impossible',
    title: 'One of the best day',
    reminderTime: '18 mar, 8:00pm',
    tags: ['nice', 'happiest', 'preety', 'cool', 'amazing'],
  ),
  
  
];
*/