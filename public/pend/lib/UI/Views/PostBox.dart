import 'package:flutter/material.dart';

Widget postBox(conx, width) {
  BuildContext context = conx;
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
                smartDashesType: SmartDashesType.enabled,//What does this mean?
                smartQuotesType: SmartQuotesType.enabled, // this too
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        100.0,
                      )
                    ),
                    borderSide: BorderSide(
                      color: Colors.white10,
                      width: 3.0
                    ),
                  ),
                  alignLabelWithHint: true, //what does this mean?
                  hintText: "Sounds good...Write it down!",
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: "Write...",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(
                      color: Colors.blue
                    ),
                  ),
                ),
                autofocus: false,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
