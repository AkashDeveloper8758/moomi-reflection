import 'package:moomi/models/note.dart';

class TagsAlgo {
  static List<Note> notesData = userNotes;
  static List<Map<String, String>> listOfTags = [];
  static List<String> keysOfDiffTags = [];
  static Map<String, int> keysCount = {};

  static List<String> getNotesTagsList(List<String> tempTagsList) {
    if (keysOfDiffTags.length > 0) keysOfDiffTags.clear();

    listOfTags = notesData.map((item) => item.tags).toList(); // get all tags
    // print('..................................................');
    // print('my tags MEGA LIST : $listOfTags');

    for (var i in listOfTags) {
      i.forEach((k, v) => {keysOfDiffTags.add(k)}); // get Keys of all tags
    }
    // print('--------------------------------------------------');
    // print('SONO -> TAGS ALGO: -> all keys: $keysOfDiffTags');
    // print('--------------------------------------------------');

    keysOfDiffTags.forEach((k) => keysCount.addAll({k: 0}));
    for (var key in keysOfDiffTags) {
      if (keysCount.containsKey(key)) {
        // map of keys and count
        keysCount[key]++;
      }
    }
    // print('SONO -> <KEYS:COUNT<ONLY>>: $keysCount');
    // print('--------------------------------------------------');
    List<int> shortKeyCount = keysCount.entries
        .map((item) => item.value)
        .toList(); // getting  counts of keys
    shortKeyCount.sort(); // shorting counts of keys
    shortKeyCount =
        shortKeyCount.reversed.toList(); // reversing the shorted list
    List<int> countKey = [];
    List<String> newtaglist = [];
    for (var i in shortKeyCount) {
      if (!countKey.contains(i)) // converting multi to single count
        countKey.add(i);
    }
    // print('SONO -> <KEYS:COUNT<ONLY>>: $countKey');
    // print('--------------------------------------------------');
    for (var i in countKey) {
      keysCount.entries.forEach((item) => {
            // fetching form keysCount in shorted manner
            if (item.value == i)
              newtaglist.add(item.key)
          });
    }

    List<String> allGeneralKeys = generalDataStore.tags.entries
        .map((item) => item.key)
        .toList(); //list of all general keys
    // print('SONO -> <all general keys>: $allGeneralKeys');
    // print('--------------------------------------------------');
    allGeneralKeys = allGeneralKeys
        .where((item) => !tempTagsList.contains(item)).toList(); // generalKey - tempKeys
    // print('SONO -> <all general - temp keys>: $allGeneralKeys');
    // print('--------------------------------------------------');
    newtaglist = newtaglist
        .where((item) => !tempTagsList.contains(item)).toList(); //newAlgoKeys - tempKeys
    allGeneralKeys = allGeneralKeys
        .where((item) => !newtaglist.contains(item)).toList(); //generalKey - newAlgoKeys

    // print('SONO -> <LAST  general - newTagsList keys>: $allGeneralKeys');
    // print('--------------------------------------------------');
    if(allGeneralKeys.length>20){
     allGeneralKeys =  allGeneralKeys.sublist(0,20);
    }
    newtaglist.addAll(allGeneralKeys);
    print('SONO -> <final key list>: $newtaglist');
    print('--------------------------------------------------');
    return newtaglist;    // returning [ most efficient ] tag list based on user [ most used tags ]
  }
}
