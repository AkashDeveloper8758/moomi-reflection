/*
import 'package:flutter/material.dart' hide Color;
import '../custom/custom_colors.dart';
import 'package:moomi/models/note.dart';
import '../custom/list_container.dart';

class Test extends StatelessWidget {
  var _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
          body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              expandedHeight: 200,
              titleSpacing: 0.0,
              //floating: true,
              pinned: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                margin: EdgeInsets.only(top: 4, left: 8, right: 8,bottom:4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(34),
                    border: Border.all(width: 1, color: MyColors.textDark)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          style:
                              TextStyle(color: MyColors.textDark, fontSize: 20),
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: '481b96ad7cf5',
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
                        'Hello, ${generalData.userName}',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: MyColors.textDark,
                        ),
                      ),
                    ),
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
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, items) => ListContainer(_userNotes[items],mediaQuery),
              childCount: _userNotes.length,
            ),
          )
        ],
        //               child: Column(
        // children: <Widget>[
        //     Container(
        //       alignment: Alignment.center,
        //       margin: EdgeInsets.only(top: mediaQuery.padding.top - 18),
        //       child: Text(
        //         'Hello, ${generalData.userName}',
        //         style: TextStyle(
        //           fontSize: 40,
        //           fontWeight: FontWeight.bold,
        //           color: MyColors.textDark,
        //         ),
        //       ),
        //     ),
        //     Text(
        //       'your all saved notes',
        //       style: TextStyle(
        //         fontSize: 20,
        //         color: MyColors.textDark,
        //       ),
        //     ),
        //     Container(
        //       padding: EdgeInsets.symmetric(
        //         horizontal: 18,
        //       ),
        //       margin: EdgeInsets.only(top: 80, left: 8, right: 8),
        //       decoration: BoxDecoration(
        //           color: Colors.white,
        //           borderRadius: BorderRadius.circular(34),
        //           border: Border.all(width: 1, color: MyColors.textDark)),
        //       child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Expanded(
        //               child: TextField(
        //                 style: TextStyle(color: MyColors.textDark, fontSize: 24),
        //                 controller: _searchController,
        //                 decoration: InputDecoration(
        //                   hintText: 'Search by tags',
        //                   hintStyle: TextStyle(fontSize: 18),
        //                   border: InputBorder.none,
        //                 ),
        //               ),
        //             ),
        //             Icon(
        //               Icons.search,
        //               color: MyColors.textMedium,
        //               size: 34,
        //             )
        //           ]),
        //     ),
        //     Container(
        //       height: 40,
        //       alignment: Alignment.centerLeft,
        //       margin: EdgeInsets.all(8),
        //       child: ListView.builder(
        //           shrinkWrap: true,
        //           itemCount: generalData.tags.length,
        //           scrollDirection: Axis.horizontal,
        //           itemBuilder: (ctx, items) {
        //             return Container(
        //               alignment: Alignment.center,
        //               padding: EdgeInsets.symmetric(horizontal: 12),
        //               margin: EdgeInsets.symmetric(horizontal: 4),
        //               decoration: BoxDecoration(
        //                   color: items != 0
        //                       ? Theme.of(context).accentColor
        //                       : Theme.of(context).primaryColor,
        //                   borderRadius: BorderRadius.circular(12)),
        //               child: Text(
        //                 generalData.tags[items],
        //                 style: TextStyle(
        //                     color: items != 0 ? Colors.black : Colors.white,
        //                     fontSize: 16),
        //               ),
        //             );
        //           }),
        //     ),
        //     Expanded(
        //       child: ListView.builder(
        //         itemBuilder: (ctx, i) => ListContainer(userNotes[i]),
        //         itemCount: userNotes.length,
        //         shrinkWrap: true,
        //         scrollDirection: Axis.vertical,
        //       ),
        //     )
      )),
    );
  }
}
*/