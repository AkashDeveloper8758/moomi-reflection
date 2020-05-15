import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:moomi/helper/dbHelper.dart';
import 'package:moomi/helper/safe.dart';
import 'dart:convert';
import 'package:moomi/models/note.dart';

class NotesProvider extends ChangeNotifier {
  static const notesTable = 'userNotes';
  List<Note> _notes = [
    //   Note(
    //     id: '1',
    //     date: DateTime.now(),
    //     description:
    //         'this is my best day ever, i had spent my day with my grandparents in park,and like ia am playing with my friend like sam dam pan and folkeor with cruse and mission impossible',
    //     title: 'One of the best day',
    //     reminderTime: '18 mar, 8:00pm',
    //     tags: {
    //       '5': 'dangerous',
    //       '6': 'puffy',
    //       '7': 'beautiful',
    //       '8': 'lovely',
    //     },
    //   ),
  ];
  List<Note> get notes {
    return [..._notes];
  }

  void addNote(Note note) async {
    _notes.add(note);
    notifyListeners();
    var checkAdd = await DbHelper.insertNote(notesTable, note.toMap());
    print('>>> adding note:STATUS: $checkAdd');
  }

  Future<void> getAllNotes() async {
    var dataList = await DbHelper.getNotes(notesTable);
    List<Note> loadedNotes = [];
    loadedNotes = dataList.map((item) {
      // print('tags items form note fetch: ${item[Safe.tags]}');
      Map<String, String> jsonTags = Map.castFrom(jsonDecode(item[Safe.tags]));
      return Note(
        id: item[Safe.id],
        title: item[Safe.title],
        description: item[Safe.description],
        tags: jsonTags,
        date: DateTime.parse(item[Safe.date]),
        reminderTime: item[Safe.reminderTime],
      );
    }).toList();
    //print('final length : ${loadedNotes.length}');

    if (loadedNotes.isEmpty) return;
    _notes = loadedNotes;
    userNotes = loadedNotes;
    notifyListeners();
  }

  Future<int> updateNote(Note note) async {
    var newNote = await DbHelper.setNotes(notesTable, note.toMap());
    print('>>> Updating note:STATUS: $newNote');
    return newNote;
  }

  Future<void> deleteNote(String id) async {
    var checkDelete;
    checkDelete = await DbHelper.removeNote(notesTable, id);

    print('>>> Deleting Note: STATUS: $checkDelete');
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
    return checkDelete;
  }

  Note removeTemperory(int index) {
    var note = _notes.removeAt(index);
    notifyListeners();
    return note;
  }

  void filterNote(List<String> tag) {
    List<Note> newNoteList = [];
    if (tag.isNotEmpty) {
      print('tag is not empty');
      for (var i in tag) {
        newNoteList = _notes.where((note) {
          return note.tags.containsValue(i);
        }).toList();
      }
    } else {
        getAllNotes();    
    }
    _notes = newNoteList;
    print(_notes.length);
    notifyListeners();
  }
}
