import 'package:flutter/material.dart';

calcSize(width) {
  if (width >= 1200)
    return width * (3 / 10);
  else
    return width;
}

Widget content(conx, width, data) {
  double size = MediaQuery.of(conx).size.width * 0.11;
  var iconColor;
  if (!data["bookmarked"])
    iconColor = Colors.white;
  else 
    iconColor = Colors.blue;

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
                  color: iconColor,
                  
                ),
                iconSize: size / 3,
                onPressed: () {
                 
                  iconColor = Colors.blue;
                },
              ),
            ),
            Text(
              data["contents"],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: size / 4, fontFamily: "Ubuntu"),
            ),
          ],
        ),
      ),
    ),
  );



}

