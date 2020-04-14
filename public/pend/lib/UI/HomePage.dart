import 'package:flutter/material.dart';
import 'package:pend/Network/ListOfData.dart';
import 'package:pend/UI/Views/AppBar.dart';
import 'package:pend/UI/Views/Comments.dart';
import 'package:pend/UI/Views/PostBox.dart';
import 'package:stack/stack.dart' as stk;

class HomePage extends StatefulWidget {
  final title;
  final contentOfText;
  final author;
  final following;
  final cake;
  final commentsOfText;
  final readersChoice;
  final bookmarked;
  final date;

  HomePage({
    Key key,
    @required this.title,
    @required this.contentOfText,
    @required this.author,
    @required this.following,
    @required this.cake,
    @required this.commentsOfText,
    @required this.readersChoice,
    @required this.bookmarked,
    @required this.date,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(
        title: title,
        contentOfText: contentOfText,
        author: author,
        following: following,
        cake: cake,
        commentsofText: commentsOfText,
        readersChoice: readersChoice,
        bookmarked: bookmarked,
        date: date,
      );
}

class _HomePageState extends State<HomePage> {
  var title;
  final contentOfText;
  final author;
  final following;
  final cake;
  final commentsofText;
  final readersChoice;
  final bookmarked;
  final date;

  _HomePageState({
    Key key,
    @required this.title,
    @required this.contentOfText,
    @required this.author,
    @required this.following,
    @required this.cake,
    @required this.commentsofText,
    @required this.readersChoice,
    @required this.bookmarked,
    @required this.date,
  });

  var data;
  var book;
  var like;
  var follow;

  var listOfContent;

  stk.Stack<String> stack = stk.Stack();
  String thislink = "";

  bool draw = false;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    book = bookmarked;
    like = cake;
    follow = following;

    fetchContentList();
    data = fillData();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (c, cons) {
      if (cons.maxWidth <= 1200)
        draw = true;
      else
        draw = false;
      var listView = ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: listOfContent.length,
        itemBuilder: (context, i) {
          return Tooltip(
            message: listOfContent[i]["contents"] ?? "No content",
            child: GestureDetector(
              onTap: () {
                stack.push(thislink);
                setState(() {
                  data = listOfContent[i];
                  this.title = listOfContent[i]["title"];
                });
              },
              child: ListTile(
                title: Text(
                  listOfContent[i]["title"] ?? "no title",
                ),
              ),
            ),
          );
        },
      );
      return Scaffold(
        appBar: appBar(context),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              var details = constraints.maxWidth > 1200;

              var column = Container(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      postBox(
                        conx: context,
                        width: calcSize(constraints.maxWidth),
                      ),
                      content(context, calcSize(constraints.maxWidth)),
                      comments(context, calcSize(constraints.maxWidth),
                          data["comments"]),
                    ],
                  ),
                ),
              );

              if (details) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Card(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: constraints.maxWidth * (1 / 5),
                          child: listView,
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
        drawer: draw ? Drawer(child: listView) : null,
      );
    });
  }

  calcSize(width) {
    if (width >= 1200) {
      return width * (3 / 4);
    } else {
      return width;
    }
  }

  fillData() {
    return {
      "title": title,
      "contents": contentOfText,
      "author": author,
      "following": following,
      "cake": cake,
      "comments": commentsofText,
      "readersChoice": readersChoice,
      "bookmarked": bookmarked,
      "date": date,
    };
  }

  Widget content(conx, width) {
    double size = MediaQuery.of(conx).size.width * 0.11;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: width,
        // height: MediaQuery.of(conx).size.height *(4/5) ,
        child: Column(
          children: <Widget>[
            data["readersChoice"]
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: stack.isNotEmpty
                          ? Tooltip(
                              message: "Last content",
                              child: IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: () {
                                  var cont = stack.pop();

                                  setState(() {
                                    data = cont;
                                  });
                                },
                              ),
                            )
                          : SizedBox(),
                      trailing: Tooltip(
                        message: "Readers' Choice",
                        child: Icon(
                          Icons.star,
                          color: Colors.blue,
                          size: size / 4,
                        ),
                      ),
                    ),
                  )
                : Container(),
            Text(
              data["title"] ?? "Title",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: size,
                fontFamily: "Ubuntu",
              ),
            ),
            ListTile(
              leading: Tooltip(
                message: "Bookmark",
                child: IconButton(
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
              ),
              trailing: Container(
                margin: EdgeInsets.all(2.0),
                padding: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: follow ? Colors.red : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      follow = !follow;
                    });
                  },
                  child: Tooltip(
                    message: follow ? "Following!" : "Click to follow!",
                    child: Wrap(
                      spacing: 0,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data["author"],
                            style: TextStyle(
                              fontSize: size / 7.5,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.add_alert,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 32.0, 8.0, 32.0),
              child: Text(
                data["contents"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size / 4,
                  fontFamily: "Ubuntu",
                ),
              ),
            ),
            ListTile(
              leading: Text(
                data["date"],
                style: TextStyle(
                  fontSize: size / 8,
                  fontFamily: "Ubuntu",
                ),
              ),
            ),
            SizedBox(
              height: 5,
              width: size,
              child: Center(
                child: Container(
                  margin: EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                  height: 2,
                  color: Colors.white,
                ),
              ),
            ),
            Tooltip(
              message: like ? ":(" : "Gift a cake!",
              child: IconButton(
                icon: Icon(Icons.cake),
                iconSize: size / 4,
                color: like ? Colors.blue : Colors.white,
                onPressed: () {
                  setState(() {
                    like = !like;
                  });
                },
              ),
            ),
            SizedBox(
              height: 5,
              width: size,
              child: Center(
                child: Container(
                  margin: EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                  height: 2,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  fetchContentList() {
    listOfContent = fetchListContents();
  }
}
