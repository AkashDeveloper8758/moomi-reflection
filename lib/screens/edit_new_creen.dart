import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moomi/helper/tagsListAlgo.dart';
import 'package:provider/provider.dart';

import '../custom/custom_colors.dart';
import '../custom/tags.dart';
import '../models/note.dart';
import '../providers/notesProvider.dart';
import '../providers/generalDataProvider.dart';

class NewEditScreen extends StatefulWidget {
  // final Function addNote;

  // NewEditScreen(this.addNote);

  @override
  _NewEditScreenState createState() => _NewEditScreenState();
}

class _NewEditScreenState extends State<NewEditScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _tagController = TextEditingController();
  // DateTime _selectedDate;
  Map<String, String> tagsListItems = {};
  var check = false;
  var updateMode = false;
  var tagTic = false;
  int lastKey;
  Note updatingNote;
  FocusNode _focusNode = FocusNode();
  @override
  void didChangeDependencies() {
    if (!check) {
      // print('dependencies called: EDIT SCREEN');
      final routeData = ModalRoute.of(context).settings.arguments as Note;
      updatingNote = routeData;
      if (updatingNote != null) {
        tagsListItems.addAll(updatingNote.tags);
        _titleController.text = updatingNote.title;
        _descriptionController.text = updatingNote.description;
        updateMode = true;
      }
      tagList();
      super.didChangeDependencies();
      check = true;
    }
  }

  @override
  void initState() {
    _focusNode.addListener(_onTagAddFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _getSelectedTags(String tag, String tagId) {
    print('edit called **');
    if (tagsListItems.containsKey(tagId))
      tagsListItems.remove(tagId);
    else
      tagsListItems.addAll({
        tagId: tag,
      });
  }

  _onTagAddFocusChange() {
    setState(() {
      tagTic = _focusNode.hasFocus;
    });
  }

  final List<Widget> tagsWidgetList = [];

  void tagList() {
    // print('ALL TAGS : ${generalDataStore.tags}');
    List<String> tempTagsItems = [];
    tagsWidgetList.clear();
    // print('tag list items :MAIN: $tagsListItems');
    if (tagsListItems.isNotEmpty) {
      tagsListItems.forEach((k, v) => {
            // print('tagListItem keys: $k'),
            tempTagsItems.add(k),
            tagsWidgetList.add(Tags(
              key: ValueKey(k),
              tagName: v,
              tagId: k,
              getTag: _getSelectedTags,
              isSelected: true,
            )),
          });
    }
    var finalTags = TagsAlgo.getNotesTagsList(tempTagsItems);
    if (finalTags.length > 0 && generalDataStore.tags.length > 0) {
      // print('generalDataStore tags are : ${generalDataStore.tags}');
      // print('final  tags are : $finalTags');

      finalTags.forEach((k) => {
            // print('tagsName: ${generalDataStore.tags[k]}'),
            // if (!tempTagsItems.contains(k))
            //   {
            tempTagsItems.add(k),
            tagsWidgetList.add(Tags(
              tagName: generalDataStore.tags[k],
              tagId: k,
              getTag: _getSelectedTags,
              isSelected: false,
            )),
          });
    }
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
      Provider.of<NotesProvider>(context, listen: false).updateNote(
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

  _onTagAdded() async {
    var tag = _tagController.text;
    if (tag.isEmpty && tag.length > 2) return;
    String key;
    if (tag.length > 3) {
      key = tag.substring(0, 3) + Random().nextInt(1000).toString();
      // print(key);
    } else
      key = tag.substring(0, 2) + Random(200).nextInt(200).toString();

    setState(() {
      tagsListItems = {...tagsListItems, key: tag};
    });

    tagList();
    var newGenData =
        GenData(id: 'generalId', userName: generalDataStore.userName, tags: {
      key: tag,
      ...generalDataStore.tags,
    });
    await Provider.of<GeneralDataProvider>(context, listen: false)
        .setGenData(newGenData);
    //await Provider.of<GeneralDataProvider>(context, listen: false) .deleteGenData();
    _tagController.text = '';
  }

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
              children: [
                ...tagsWidgetList,
                Container(
                  height: 60,
                  alignment: Alignment.centerLeft,
                  // alignment: Alignment.centerRight,s
                  width: 200,
                  // margin: EdgeInsets.only(
                  //     right: MediaQuery.of(context).size.width * .4),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      TextField(
                        controller: _tagController,
                        focusNode: _focusNode,
                        onSubmitted: (_) {},
                        maxLength: 15,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            // labelStyle: TextStyle(fontSize: 26),
                            filled: false,
                            hintText: 'Enter you new tag',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(48),
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                 width: 2),
                            )),
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: tagTic
                            ? GestureDetector(
                                onTap: () {
                                  FocusScopeNode focusScopeNode =
                                      FocusScope.of(context);
                                  if (!focusScopeNode.hasPrimaryFocus) {
                                    print('primary focus loose');
                                    focusScopeNode.unfocus();
                                  }
                                  _onTagAdded();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).primaryColor),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : SizedBox(),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _submitData,
        backgroundColor: Theme.of(context).primaryColor,
        icon: Icon(Icons.save, color: Colors.white),
        label: Text(
          updateMode ? 'Update' : 'Save',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
