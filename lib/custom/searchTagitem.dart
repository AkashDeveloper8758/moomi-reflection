import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom/custom_colors.dart';
import '../providers/notesProvider.dart';

class SearchTagItem extends StatefulWidget {
  SearchTagItem({
    Key key,
    @required this.tagName,
    @required this.getSearchTag,
  }) : super(key: key);

  final String tagName;
  final Function getSearchTag;

  @override
  _SearchTagItemState createState() => _SearchTagItemState();
}

class _SearchTagItemState extends State<SearchTagItem> {
  bool _isSelect = false;

  @override
  Widget build(BuildContext context) {
   // print('search tag list build');
    return GestureDetector(
      onTap: (){
        setState(() {
          _isSelect = !_isSelect;
          widget.getSearchTag(widget.tagName,);
        });
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: _isSelect ? Theme.of(context).primaryColor : Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 2, offset: Offset(1, 1), color: Colors.grey[400])
          ],
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          children: <Widget>[
            Container(
              height: 8,
              width: 8,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isSelect
                      ? Colors.white
                      : Theme.of(context).primaryColor),
            ),
            Text(
              widget.tagName,
              style: TextStyle(
                fontSize: 16,
                color: _isSelect ? Colors.white : MyColors.textDark,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
