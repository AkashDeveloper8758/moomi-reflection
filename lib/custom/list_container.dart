import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moomi/custom/custom_colors.dart';
import 'package:moomi/models/note.dart';

class ListContainer extends StatelessWidget {
  final Note note;
  final query;
  ListContainer(this.note, this.query);

  @override
  Widget build(BuildContext context) {
    final screenWidth = query.size.width;
    print(query.size.width);
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 250,
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color:Colors.black, blurRadius: 2, offset: Offset(1, 1)),
            ]),
        // color: Colors.blue,
        child: LayoutBuilder(
          builder: (ctx, constraints) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: constraints.maxWidth * .7,
                      height: constraints.maxHeight * .7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(4),
                            child: Text(
                              note.title,
                              style: TextStyle(
                                  fontSize: screenWidth > 380 ? 26 : 22,
                                  color: MyColors.textDark,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(4),
                              child: Text(
                                note.description,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: MyColors.textMedium,
                                  letterSpacing: .4,
                                ),
                                overflow: TextOverflow.fade,
                                maxLines: 4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: constraints.maxWidth * .25,
                      // color: Colors.orange,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(4)),
                            child: Text(
                              DateFormat('MMMd').format(note.dateTime),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          // Expanded(
                          Container(
                            height: constraints.maxHeight * .6,
                            child: ListView.builder(
                                itemCount: note.tags.length,
                                itemBuilder: (ctx, item) {
                                  return Column(
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(4),
                                        margin: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).accentColor,
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        child: Text(
                                          note.tags[item],
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: MyColors.textDark,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                // ),
                Container(
                    decoration: BoxDecoration(color:Theme.of(context).primaryColor.withOpacity(.1),
                    borderRadius: BorderRadius.circular(16)),
                   alignment: Alignment.centerLeft,
                  height: constraints.maxHeight * .2,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        padding: EdgeInsets.all(4),
                        icon: Icon(
                          Icons.alarm,
                          size: 36,
                        ),
                        onPressed: () {},
                        color: MyColors.greenCustom,
                      ),
                      Text(
                        note.reminderTime,
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
