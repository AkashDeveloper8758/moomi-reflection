import 'package:flutter/cupertino.dart';

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
}

class GenData {
  final String userName;
  final Map<String, String> tags;
  GenData({this.userName, this.tags});
}

final GenData generalData = GenData(
  tags: {
    '1': 'All',
    '2': 'good',
    '3': 'bad news',
    '4': 'cool guy',
    '5': 'dangerous',
    '6': 'puffy',
    '7': 'beautiful',
    '8': 'lovely',
  },
  userName: 'akash',
);

final List<Note> userNotes = [
  Note(
    id: '1',
    date: DateTime.now(),
    description:
        'this is my best day ever, i had spent my day with my grandparents in park,and like ia am playing with my friend like sam dam pan and folkeor with cruse and mission impossible',
    title: 'One of the best day',
    reminderTime: '18 mar, 8:00pm',
    tags: {
    '5': 'dangerous',
    '6': 'puffy',
    '7': 'beautiful',
    '8': 'lovely',
  },
  ),
];
