import 'package:flutter/material.dart';

import '../models/note.dart';
import './list_item.dart';

class ListContainer extends StatelessWidget {
  final List<Note> notes;
  final query;
  ListContainer(this.notes, this.query);

  @override
  Widget build(BuildContext context) {
    return notes.isEmpty 
    ? Column(
            children: <Widget>[
              Text(
                'No Notes added yet !',
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 50,
              ),
            ],
          )
    : ListView(
      shrinkWrap: true,
            children: notes.map((tx) => ListContainerItem(
                  key: ValueKey(tx.id),
                  note: tx,
                  query: query,
              //    deleteTx: deleteTx,
                )).toList(),
          );
  }
}