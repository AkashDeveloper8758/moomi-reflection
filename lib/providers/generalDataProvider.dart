import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:moomi/helper/dbHelper.dart';
import 'package:moomi/helper/safe.dart';
import 'package:moomi/models/note.dart';

class GeneralDataProvider extends ChangeNotifier {
  final _tableName = 'generalData';
  Future setGenData(GenData genData) async {
    var data = await DbHelper.getGenData(_tableName);
    if(data.length>0){
      await DbHelper.updateGenData(_tableName, genData.toMap());
    }else{
      await DbHelper.setGeneralData(_tableName, genData.toMap());
    }
    generalDataStore = genData;
    print('GEN : updaae form <general data> : ${genData.tags}');
    notifyListeners();
  }

  Future<void> getGenData() async {
    var data = await DbHelper.getGenData(_tableName);
    if (data.length > 0) {
       Map<String, String> tagsList =
           Map.castFrom(jsonDecode(data[0][Safe.tagsList]));
       generalDataStore = GenData(id: data[0][Safe.generalId], tags: tagsList,userName: data[0][Safe.userName]);
       print('GEN: printing from <general Keys: >: ${generalDataStore.tags}');
       notifyListeners();
    }else print('GEN: data length is null');
  }
  Future<void> deleteGenData() async {
    await DbHelper.deleteGenData(_tableName);
    getGenData();
  }
}
