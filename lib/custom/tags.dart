import 'package:flutter/material.dart';
import 'package:moomi/custom/custom_colors.dart';

class Tags extends StatelessWidget {
  final String text;
  Tags(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(18)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(color: MyColors.textMedium, fontSize: 18),
          ),
          Container(
            margin: EdgeInsets.only(left:8),            
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MyColors.greenCustom),
            child: Icon(
              Icons.add,
              color:Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
