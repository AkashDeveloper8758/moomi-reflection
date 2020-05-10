import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:moomi/helper/dbHelper.dart';
import 'package:moomi/helper/safe.dart';
import 'package:moomi/models/note.dart';

class GeneralDataProvider extends ChangeNotifier {
  final _tableName = 'generalData';
  // GenData _generalData;
  // GenData get generalData => _generalData;

  Future setGenData(GenData genData) async {
    var data = await DbHelper.getGenData(_tableName);
    if(data.length>0){
      print('in U - line ***');
      await DbHelper.updateGenData(_tableName, genData.toMap());
      print('tags UPDATED ))): }');
    }else{
      await DbHelper.setGeneralData(_tableName, genData.toMap());
      print('tags ADDED ))): }');
    }
    generalDataStore = genData;
    notifyListeners();
  }

  Future<void> getGenData() async {
    var data = await DbHelper.getGenData(_tableName);
    //print('---> tags in Database : ${data.length}');
    if (data.length > 0) {
     // print('all fetched tags are : ${data[0][Safe.tagsList]}');
      print('all fetched DATA ^^^^ : ${data[0]}');
      //print('decoded tags are :  ${jsonDecode(data[0][Safe.tagsList])}');
       Map<String, String> tagsList =
           Map.castFrom(jsonDecode(data[0][Safe.tagsList]));
       generalDataStore = GenData(id: data[0][Safe.generalId], tags: tagsList,userName: data[0][Safe.userName]);
       notifyListeners();
    
     // print('Getting GEN DATA form DATABASE: ${generalDataStore.tags}');
    }
  }

  // Future<int> updateGeneralData(GenData genData) async {
  //   var updatedData = await DbHelper.updateGenData(_tableName, genData.toMap());
  //   await getGenData();
  //   return updatedData;
  // }

  Future<void> deleteGenData() async {
    await DbHelper.deleteGenData(_tableName);
    getGenData();
  }
}
