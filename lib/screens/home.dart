import 'package:flutter/material.dart' hide Color;
import 'package:provider/provider.dart';

import 'package:moomi/models/note.dart';
import '../screens/edit_new_creen.dart';
import '../custom/custom_colors.dart';
import '../custom/home_list.dart';
import '../providers/generalDataProvider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
  //  Provider.of<GeneralDataProvider>(context).getGenData();
    print('home REBUILD ***>');
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: Builder(
          builder: (context) => CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                  expandedHeight: 150,
                  titleSpacing: 0.0,
                  pinned: true,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  title: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 18,
                    ),
                    margin:
                        EdgeInsets.only(top: 10, left: 8, right: 8, bottom: 4),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(34),
                        border: Border.all(width: 1, color: MyColors.textDark)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextField(
                              // text feild
                              style: TextStyle(
                                  color: MyColors.textDark, fontSize: 20),
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Search by tags',
                                hintStyle: TextStyle(fontSize: 18),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.search,
                            color: MyColors.textMedium,
                            size: 34,
                          )
                        ]),
                  ),
                  centerTitle: true,
                  flexibleSpace: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Column(
                      children: <Widget>[
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 60),
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
                  )),
              HomeList(mediaQuery: mediaQuery),
            ],
          ),
        ),
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
