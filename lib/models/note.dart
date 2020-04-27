import 'package:flutter/cupertino.dart';

class Note {
  final String id;
  final String title;
  final String description;
  final List<String> tags;
  final DateTime dateTime;
  final String reminderTime;
  Note({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.tags,
    @required this.dateTime,
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


final List<Note> userNotes = [
  Note(
    id: '1',
    dateTime: DateTime.now(),
    description:
        'this is my best day ever, i had spent my day with my grandparents in park,and like ia am playing with my friend like sam dam pan and folkeor with cruse and mission impossible',
    title: 'One of the best day',
    reminderTime: '18 mar, 8:00pm',
    tags: ['nice', 'happiest', 'preety', 'cool', 'amazing'],
  ),
  Note(
    id: '2',
    dateTime: DateTime.now(),
    description: 'worst day of my lifegrandparents in park when i  best day ever, i had spent my day with my grandparents in park,and',
    title: 'One of the worst day of my life like a hell',
    reminderTime: '58 mar 2545',
    tags: ['worst'],
  ),
  Note(
    id: '3',
    dateTime: DateTime.now(),
    description:
        'this is my best day ever, i had spent my day with my grandparents in park this is my best day ever, i had spent my day with my grandparents in park',
    title: 'One of the cool day',
    reminderTime: '18 mar, 8:00pm',
    tags: ['nice', 'happiest', 'ok day'],
  ),
  Note(
    id: '4',
    dateTime: DateTime.now(),
    description:
        'this is my best day ever, i had spent my day with my grandparents in park',
    title: 'One of the best day',
    reminderTime: '18 mar, 9:00pm',
    tags: ['nice', 'happiest', 'preety'],
  ),
];
