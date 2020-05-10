import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/notesProvider.dart';
import './list_item.dart';
import '../screens/edit_new_creen.dart';

class HomeList extends StatelessWidget {
  const HomeList({
    Key key,
    @required this.mediaQuery,
  }) : super(key: key);

  final MediaQueryData mediaQuery;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<NotesProvider>(context, listen: false)
          .getAllNotes(),
      builder: (ctx, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? SliverToBoxAdapter(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Consumer<NotesProvider>(
                //consumer of sql note fetch
                builder: (ctx, notesItem, ch) {
                  // print(
                  //     'home : notes length : ${notesItem.notes.length}');

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
                      : SliverToBoxAdapter(
                          // if notes are empty
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
