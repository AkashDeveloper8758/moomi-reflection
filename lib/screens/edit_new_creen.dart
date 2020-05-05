import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom/custom_colors.dart';
import '../custom/tags.dart';
import '../models/note.dart';
import '../providers/notesProvider.dart';

class NewEditScreen extends StatefulWidget {
  // final Function addNote;

  // NewEditScreen(this.addNote);

  @override
  _NewEditScreenState createState() => _NewEditScreenState();
}

class _NewEditScreenState extends State<NewEditScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  // DateTime _selectedDate;
  Map<String, String> tagsListItems = {};
  var check = false;
  var updateMode = false;
  Note updatingNote;

  @override
  void didChangeDependencies() {
    if (!check) { 
      final routeData = ModalRoute.of(context).settings.arguments as Note;
      updatingNote = routeData;

      if (updatingNote !=null) {
        // print('UPDATE MODE');
        // print('updating note: $updatingNote');
        tagsListItems.addAll(updatingNote.tags);
        _titleController.text = updatingNote.title;
        _descriptionController.text = updatingNote.description;
        updateMode = true;
      }
      tagList(); //calling tagList from didChangeDependencies as calling from intiState is boilerplate,we need context
      super.didChangeDependencies();
      check = true;
    }
  }

  void _getSelectedTags(String tag, String tagId) {
    if (tagsListItems.containsKey(tagId))
      tagsListItems.remove(tagId);
    else
      tagsListItems.addAll({
        tagId: tag,
      });
  }

  final List<Widget> tagsWidgetList = [];

  void tagList() {
    var tempTagsItems = [];
    if (tagsListItems.isNotEmpty) {
      tagsListItems.forEach((k, v) => {
            tempTagsItems.add(k),
            tagsWidgetList.add(Tags(
              tagName: v,
              tagId: k,
              getTag: _getSelectedTags,
              isSelected: true,
            )),
            // print('temp tags items : $tempTagsItems')
          });
    }
    generalData.tags.forEach((k, v) => {
          if (!tempTagsItems.contains(k))
            {
              tempTagsItems.add(k),
              tagsWidgetList.add(Tags(
                tagName: v,
                tagId: k,
                getTag: _getSelectedTags,
                isSelected: false,
              )),
            },
        });
  }

  void _submitData() {
    if (_descriptionController.text.isEmpty) {
      return;
    }
    final enterdTitle = _titleController.text;
    final enterdDiscription = _descriptionController.text;

    if (enterdTitle.isEmpty || enterdDiscription.isEmpty) {
      return;
    }
    if (tagsListItems == null) tagsListItems = {'X': 'X'};
    if (updateMode) {
      // userNotes[noteItem] = Note(
      //   date: DateTime.now(),
      //   title: enterdTitle,
      //   description: enterdDiscription,
      //   tags: tagsListItems,
      //   reminderTime: null,
      //   id: DateTime.now().toIso8601String(),
      // );
      Provider.of<NotesProvider>(context,listen: false).updateNote(
        Note(
          date: DateTime.now(),
          title: enterdTitle,
          description: enterdDiscription,
          tags: tagsListItems,
          reminderTime: null,
          id: updatingNote.id,
        ),
      );
    } else {
      // userNotes.add(
      //   Note(
      //       date: DateTime.now(),
      //       title: enterdTitle,
      //       description: enterdDiscription,
      //       tags: tagsListItems,
      //       reminderTime: null,
      //       id: DateTime.now().toIso8601String()),
      // );
      Provider.of<NotesProvider>(context, listen: false).addNote(
        Note(
            date: DateTime.now(),
            title: enterdTitle,
            description: enterdDiscription,
            tags: tagsListItems,
            reminderTime: null,
            id: DateTime.now().toIso8601String()),
      );
    }
    Navigator.of(context).pop();
  }

  // void _presentDatePicker() async {
  //   final pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2019),
  //     lastDate: DateTime.now(),
  //   );
  //   if (pickedDate == null) {
  //     return;
  //   }
  //   setState(() {
  //     _selectedDate = pickedDate;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          updateMode ? 'Update Note' : 'Create Note',
          style: TextStyle(color: MyColors.textDark, fontSize: 24),
        ),
        backgroundColor: MyColors.customBackgound,
        elevation: 0,
        iconTheme: IconThemeData(color: MyColors.textDark),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: TextField(
                    onSubmitted: (_) => _submitData,
                    controller: _titleController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      hintText: 'Enter Title',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color:
                              Theme.of(context).primaryColor.withOpacity(.6)),
                    ),
                  ),
                ),
                Container(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(fontSize: 22, color: MyColors.textDark),
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      hintText: 'note description here',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          fontSize: 22,
                          color: MyColors.textLight.withOpacity(.8)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: tagsWidgetList,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _submitData,
        backgroundColor: Theme.of(context).primaryColor,
        icon: Icon(Icons.save, color: Colors.white),
        label: Text(
          'Save',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
