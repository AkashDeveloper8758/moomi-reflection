import 'package:flutter/material.dart' hide Color;
import 'package:moomi/custom/list_item.dart';
import 'package:provider/provider.dart';

import '../screens/edit_new_creen.dart';
import '../custom/custom_colors.dart';
import '../models/note.dart';
import '../providers/notesProvider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: Builder(
          builder: (context) => CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                  expandedHeight: 150,
                  titleSpacing: 0.0,
                  //floating: true,
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
              FutureBuilder(
                future: Provider.of<NotesProvider>(context, listen: false)
                    .getAllNotes(),
                builder: (ctx, snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting
                      ? SliverToBoxAdapter(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Consumer<NotesProvider>( //consumer of sql note fetch
                          builder: (ctx, notesItem, ch) {
                            print(
                                'home : notes length : ${notesItem.notes.length}');

                            return notesItem.notes.length > 0
                                ? SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (ctx, i) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (cts) =>
                                                    NewEditScreen(),
                                                settings: RouteSettings(
                                                    arguments:
                                                        notesItem.notes[i]),
                                              ),
                                            );
                                          },
                                          child: Dismissible(
                                            key:
                                                ValueKey(notesItem.notes[i].id),
                                            direction:
                                                DismissDirection.endToStart,
                                            background: Container(
                                              color: Colors.red,
                                              alignment: Alignment.centerRight,
                                              padding:
                                                  EdgeInsets.only(right: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                    size: 35,
                                                  ),
                                                  Text('Delete',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18)),
                                                ],
                                              ),
                                            ),
                                            //main note list items ---------------------------
                                            child: ListContainerItem(
                                              note: notesItem.notes[i],
                                              query: mediaQuery,
                                              key: ValueKey(
                                                  notesItem.notes[i].id),
                                            ),
                                            confirmDismiss: (direction) {
                                              return buildShowDialog(
                                                context,
                                              );
                                            },
                                            onDismissed: (direction) {
                                              Provider.of<NotesProvider>(
                                                      context,
                                                      listen: false)
                                                  .deleteNote(
                                                      notesItem.notes[i].id);
                                            },
                                          ),
                                        );
                                      },
                                      childCount: notesItem.notes.length,
                                    ),
                                  )
                                : SliverToBoxAdapter( // if notes are empty
                                    child: Center(
                                        heightFactor: 16,
                                        child: Text(
                                          'no notes found yet !!',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  );
                          },
                        );
                },
              ),
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

  Future<bool> buildShowDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Delete this note ? '),
          content: Text(
              'Do you really want to delete this note , you can\'t recover it.'),
          actions: <Widget>[
            FlatButton(
                child: Text(
                  'Yes,Delete',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                }),
            FlatButton(
              child: Text('Cancel',
                  style: TextStyle(fontSize: 18, color: Colors.purple)),
              onPressed: () {
                Navigator.of(ctx).pop(false);
              },
            ),
          ],
        );
      },
    );
  }
}
