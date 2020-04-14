import 'package:flutter/material.dart';

class postBox extends StatefulWidget {
  final conx;
  final width;
  postBox({
    Key key,
    this.conx,
    this.width
  }): super(key: key);
  @override
  _postBoxState createState() => _postBoxState(
    conx: conx,
    width: width,
  );
}

class _postBoxState extends State<postBox> {
  final conx;
  final width;

  _postBoxState({
    Key key,
    this.conx,
    this.width
  });

  @override
  Widget build(BuildContext context) {
    return Container(
    alignment: Alignment.topCenter,
    child: Card(
      child: SizedBox(
        // height: MediaQuery.of(context).size.height/10,
        width: width,
        child: Column(
          children: <Widget>[
            Text(
              "PostBox",
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                maxLines: null,
                showCursor: true,
                smartDashesType: SmartDashesType.enabled, //What does this mean?
                smartQuotesType: SmartQuotesType.enabled, // this too
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(100.0),
                    ),
                    borderSide: BorderSide(color: Colors.white10, width: 3.0),
                  ),
                  alignLabelWithHint: true, //what does this mean?
                  hintText: "Sounds good...Write it down!",
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: "Write...",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                autofocus: false,
              ),
            ),
            ListTile(
              leading: IconButton(
                icon: Icon(
                  Icons.photo_camera,
                ),
                color: Colors.white,
                onPressed: () {},
              ),
              trailing: RaisedButton(
                child: Text(
                  "Submit",
                ),
                onPressed: () {
                  
                },
              ),
            )
          ],
        ),
      ),
    ),
  );
  }

  
}



/*
Widget postbox(conx, width) {
  return Container(
    alignment: Alignment.topCenter,
    child: Card(
      child: SizedBox(
        // height: MediaQuery.of(context).size.height/10,
        width: width,
        child: Column(
          children: <Widget>[
            Text(
              "PostBox",
              style: TextStyle(
                fontFamily: 'Ubuntu',
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                maxLines: null,
                showCursor: true,
                smartDashesType: SmartDashesType.enabled, //What does this mean?
                smartQuotesType: SmartQuotesType.enabled, // this too
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(100.0),
                    ),
                    borderSide: BorderSide(color: Colors.white10, width: 3.0),
                  ),
                  alignLabelWithHint: true, //what does this mean?
                  hintText: "Sounds good...Write it down!",
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: "Write...",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
                autofocus: false,
              ),
            ),
            ListTile(
              leading: IconButton(
                icon: Icon(
                  Icons.photo_camera,
                ),
                color: Colors.white,
                onPressed: () {},
              ),
              trailing: RaisedButton(
                child: Text(
                  "Submit",
                ),
                onPressed: () {

                },
              ),
            )
          ],
        ),
      ),
    ),
  );
}
*/