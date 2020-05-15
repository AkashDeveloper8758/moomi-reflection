import 'package:flutter/material.dart' hide Color;
import 'package:provider/provider.dart';

import 'package:moomi/custom/home_list.dart';
import 'package:moomi/models/note.dart';
import '../screens/edit_new_creen.dart';
import '../custom/searchTagitem.dart';
import '../custom/custom_colors.dart';
import '../custom/home_list.dart';
import '../providers/generalDataProvider.dart';
import '../providers/notesProvider.dart';

class TestingHome extends StatefulWidget {
  @override
  _TestingHomeState createState() => _TestingHomeState();
}

class _TestingHomeState extends State<TestingHome> {
  final _searchController = TextEditingController();
  var check = true;
  List<String> _searchTagsList = [];

  @override
  void didChangeDependencies() {
    if (check) {
      Provider.of<GeneralDataProvider>(context, listen: false).getGenData();
      check = !check;
    }
    super.didChangeDependencies();
  }

  void _getSearchTag(String tagName) async {
    if (_searchTagsList.isEmpty) {
      _searchTagsList.add(tagName);
    } else {
      if (_searchTagsList.contains(tagName))
        _searchTagsList.remove(tagName);
      else
        _searchTagsList.add(tagName);
    }
    await Provider.of<NotesProvider>(context, listen: false)
        .filterNote(_searchTagsList);
    print('searching tags list ARE: $_searchTagsList');
  }

  @override
  Widget build(BuildContext context) {
    print('TestingHome REBUILD ***>');

    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 60),
                  child: Text(
                    'Hello, ${generalDataStore.userName}',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: MyColors.textDark,
                    ),
                  )),
              Text(
                'your all saved notes',
                style: TextStyle(
                  fontSize: 20,
                  color: MyColors.textMedium,
                ),
              ),
            ],
          ),
          FutureBuilder(
            future: Provider.of<GeneralDataProvider>(context, listen: false)
                .getGenData(),
            builder: (ctx, snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? SizedBox(
                      height: 10,
                    )
                  : Consumer<GeneralDataProvider>(
                      builder: (ctx, genData, _) {
                        List<String> myTagsList = genData
                            .myGeneralData.tags.entries
                            .map((item) => item.value)
                            .toList();
                        return Container(
                          margin: const EdgeInsets.only(top: 8, left: 8),
                          height: 40,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (ctx, i) {
                              print(
                                  'general tag list : ${generalDataStore.tags}');
                              return SearchTagItem(
                                tagName: myTagsList[i],
                                getSearchTag: _getSearchTag,
                                //  key: ValueKey(myTagsList),
                              );
                            },
                            itemCount: myTagsList.length,
                          ),
                        );
                      },
                    );
            },
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              child: HomeList(
                mediaQuery: mediaQuery,
              ),
            ),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (ctx) => NewEditScreen()));
          },
          backgroundColor: Theme.of(context).primaryColor,
          splashColor: Theme.of(context).primaryColor.withOpacity(.5),
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 38,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
