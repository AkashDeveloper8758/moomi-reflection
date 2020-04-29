import 'package:flutter/material.dart';
import 'package:moomi/custom/custom_colors.dart';

class Tags extends StatefulWidget {
  final String text;
  Tags(this.text);

  @override
  _TagsState createState() => _TagsState();
}

class _TagsState extends State<Tags> {
  bool taped = false;

  _taped() {
    setState(() {
      taped = !taped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 0),
      decoration: BoxDecoration(
          color: Theme.of(context).accentColor.withOpacity(.7),
          borderRadius: BorderRadius.circular(28)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            widget.text,
            style: TextStyle(color: MyColors.textMedium, fontSize: 18),
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            height: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: taped?Theme.of(context).primaryColor:MyColors.greenCustom,
                boxShadow: [
                  BoxShadow(blurRadius: 3, color:taped?Theme.of(context).primaryColor:MyColors.greenCustom)
                ]),
            child: IconButton(
              iconSize: 24,
              // alignment: Alignment.topCenter,
              icon: Icon(
                taped?Icons.remove:Icons.add,
                color: Colors.white,
              ),
              onPressed: _taped,
            ),
          ),
        ],
      ),
    );
  }
}
