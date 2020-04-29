import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../custom/custom_colors.dart';
import '../custom/tags.dart';
import '../models/note.dart';

class NewEditScreen extends StatefulWidget {
  final Function addNote;

  NewEditScreen(this.addNote);

  @override
  _NewEditScreenState createState() => _NewEditScreenState();
}

class _NewEditScreenState extends State<NewEditScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate;

  final List<Widget> tagsWidgetList = [];

  void tagList() {
    generalData.tags
        .map(
          (item) => {
          //  print('item: $item'),
            tagsWidgetList.add(
              Tags(item),
            ),
          },
        )
        .toList();
  }

  @override
  void initState() {
    print('calling tagList');
    tagList();
    super.initState();
  }

  void _submitData() {
    // if (_descriptionController.text.isEmpty) {
    //   return;
    // }
    final enterdTitle = _titleController.text;
    final enterdDiscription = _descriptionController.text;

    if (enterdTitle.isEmpty ||
        enterdDiscription.isEmpty ||
        _selectedDate == null) {
      return;
    }

    widget.addNote(
      enterdTitle,
      enterdDiscription,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Note',
          style: TextStyle(color: MyColors.textDark),
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
                boxShadow: [
                  BoxShadow(
                      blurRadius: 1, color: Colors.black, offset: Offset(0, 0))
                ],
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: tagsWidgetList,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      _selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                    ),
                    FlatButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _presentDatePicker,
                    ),
                  ],
                ),
              ],
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
