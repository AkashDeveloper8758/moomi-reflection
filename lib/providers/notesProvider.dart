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

  void addNote(Note note)async {
    _notes.add(note);
    notifyListeners();
    var checkAdd = await  DbHelper.insertNote(notesTable, note.toMap());
    print('>>> adding note:STATUS: $checkAdd');
  }

  Future<void> getAllNotes() async {
    
    
   
    var dataList = await DbHelper.getNotes(notesTable);
    //print('... getting notes: $dataList');
    // print('... TITLE: ${dataList[0]['id']}');
    // print('... TITLE: form safe${dataList[0][Safe.id]}');
    List<Note> loadedNotes = [];
    // loadedNotes[0].tags.forEach((k,v){
    //   print('key: $k value: $v');
    // });
    var mapArgs = DateTime.parse(dataList[0][Safe.date]);
    //print('map args: $mapArgs');
    // if(mapArgs is DateTime)
    // print('date are DateTime');
    // else print('TERMINATE X');
    // print('decoded string is: $jsonEncode(dataList[0][Safe.tags] as Map}');

    // if(json.decode(dataList[0][Safe.tags]) is Map){
    //   print('tags are MAP HURREY !!');
    // }else print('TERMINATE M');

    loadedNotes = dataList.map((item) {
      print('.... inside map');
   
      return Note(       
         id: item[Safe.id],
        title: item[Safe.title],
        description: item[Safe.description],
        tags: jsonDecode(item[Safe.tags]),
        date: DateTime.parse(item[Safe.date]) ,
        reminderTime: item[Safe.reminderTime],
      );
      // print('reached after addition ');
    }).toList();
   // print('final length : ${loadedNotes.length}');

    if (loadedNotes.isEmpty) return;
    _notes = loadedNotes;
    notifyListeners();
  }

  Future<int> updateNote(Note note) async {
    final checkUpdate = await DbHelper.setNotes(notesTable, note.toMap());
    print('>>> Updating note:STATUS: $checkUpdate');
    return checkUpdate;
  }

  Future<void> deleteNote() async {
    final checkDelete = await DbHelper.removeNote(notesTable);
    print('>>> Deleting Note: STATUS: $checkDelete');
  }
}
