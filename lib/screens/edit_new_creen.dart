import 'package:flutter/material.dart';
import 'package:moomi/custom/custom_colors.dart';
import 'package:moomi/custom/tags.dart';
import 'package:moomi/models/note.dart';

class NewEditScreen extends StatefulWidget {
  @override
  _NewEditScreenState createState() => _NewEditScreenState();
}

class _NewEditScreenState extends State<NewEditScreen> {
  var _titleController = TextEditingController();

  var _descriptionController = TextEditingController();

  final List<Widget> tagsWidgetList = [];

  void tagList() {
    generalData.tags
        .map(
          (item) => {
            print('item: $item'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Note',style: TextStyle(color: MyColors.textDark),),
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
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
        icon: Icon(Icons.save,color:Colors.white),
        label: Text('Save',style: TextStyle(fontSize: 16,color: Colors.white),),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
