import 'package:flutter/material.dart';
import 'package:moomi/custom/custom_colors.dart';

class Tags extends StatefulWidget {
  final String tagName, tagId;
  final Function getTag;
  final bool isSelected;
  Tags({this.tagName, this.tagId, this.getTag,this.isSelected});

  @override
  _TagsState createState() => _TagsState();
}

class _TagsState extends State<Tags> {
  bool taped = false;
  bool check = true;

  _tapedState(String tagValue, String tagId) {
    setState(() {
      taped = !taped;
      // print('<STATE CHANGE TAPS>: $taped');
      widget.getTag(tagValue, tagId);
      //   print('tag:tag added : $tagValue');
    });

  }

  @override
  Widget build(BuildContext context) {
    if(check){
    taped = widget.isSelected;
    check = false;
    }

    return Container(
      padding: EdgeInsets.only(top: 4, bottom: 4, left: 12, right: 8),
      decoration: BoxDecoration(
          color: taped ? Theme.of(context).primaryColor.withOpacity(.8) : Colors.white,
          border: Border.all(width: taped?1:2, color: taped?Theme.of(context).primaryColor:MyColors.greenCustom.withOpacity(.7)),
          borderRadius: BorderRadius.circular(28)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            widget.tagName,
            style: TextStyle(color: taped?Colors.white:MyColors.textMedium, fontSize: 16),
          ),
          GestureDetector(
            onTap: ()=> _tapedState(widget.tagName, widget.tagId),
                      child: Container(
              height: 25,
              margin: EdgeInsets.only(left: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    taped ? Colors.red.withOpacity(1) : MyColors.greenCustom,
              ),
              child: Icon(
                  taped ? Icons.remove : Icons.add,
                  color: Colors.white,
                ),
            ),
          ),
        ],
      ),
    );
  }
}
