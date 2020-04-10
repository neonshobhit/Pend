import 'package:flutter/material.dart';
import 'package:pend/UI/Views/AppBar.dart';
import 'package:pend/UI/Views/Comments.dart';
import 'package:pend/UI/Views/Content.dart';
import 'package:pend/UI/Views/PostBox.dart';

class HomePage extends StatefulWidget {
  final title;
  final contentOfText;
  final author;
  final following;
  final drumRolls;
  final commentsOfText;
  final readersChoice;
  final bookmarked;

  HomePage({
    Key key,
    @required this.title,
    @required this.contentOfText,
    @required this.author,
    @required this.following,
    @required this.drumRolls,
    @required this.commentsOfText,
    @required this.readersChoice,
    @required this.bookmarked,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(
    title: title,
    contentOfText: contentOfText,
    author: author,
    following: following,
    drumRolls: drumRolls,
    commentsofText: commentsOfText,
    readersChoice: readersChoice,
    bookmarked: bookmarked
   );
}

class _HomePageState extends State<HomePage> {
  final title;
  final contentOfText;
  final author;
  final following;
  final drumRolls;
  final commentsofText;
  final readersChoice;
  final bookmarked;

  _HomePageState({
    Key key,
    @required this.title,
    @required this.contentOfText,
    @required this.author,
    @required this.following,
    @required this.drumRolls,
    @required this.commentsofText,
    @required this.readersChoice,
    @required this.bookmarked,
  });

  var data;
  var book;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    book = bookmarked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            var details = constraints.maxWidth > 1200;
            data = fillData();
            var column = Container(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    postBox(context, calcSize(constraints.maxWidth)),
                    content(context, calcSize(constraints.maxWidth), data),
                    comments(context, calcSize(constraints.maxWidth)),
                  ],
                ),
              ),
            );
            
            if (details) {
              return Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Card(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: double.infinity,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "ListBox",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  column,
                ],
              );
            } else {
              return column;
            }
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          elevation: 1.0,
          onPressed: () {},
          child: Icon(
            Icons.add,
          ),
        ),
      ),
      drawer: Drawer(),
    );
  }

  calcSize(width) {
    if (width >= 1200) {
      return width * (3 / 4);
    } else {
      return width;
    }
  }

  fillData() {
    return  {
      "title": title,
      "contents": contentOfText,
      "author": author,
      "following": following,
      "drumRolls": drumRolls,
      "comments": commentsofText,
      "readersChoice": readersChoice,
      "bookmarked": bookmarked,
    };
  }



  Widget content(conx, width, data) {
  double size = MediaQuery.of(conx).size.width * 0.11;

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      child: SizedBox(
        width: width,
        // height: MediaQuery.of(conx).size.height *(4/5) ,
        child: Column(
          children: <Widget>[
            Text(
              data["title"] ?? "Title",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: size,
                fontFamily: "Ubuntu",
              ),
            ),
            ListTile(
              leading: IconButton(
                icon: Icon(
                  Icons.bookmark,
                ),
                color: book ? Colors.white : Colors.blue,
                iconSize: size / 3,
                onPressed: () {
                  setState(() {
                    book = !book;
                  });
                  
                },
              ),
              trailing: Text(
                data["author"],
                style: TextStyle(
                  fontSize: size/8,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 32.0),
              child: Text(
                data["contents"],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: size / 4, fontFamily: "Ubuntu"),
              ),
            ),


          ],
        ),
      ),
    ),
  );



}
}
