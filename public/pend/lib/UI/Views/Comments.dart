import 'package:flutter/material.dart';

Widget comments(conx, width, commentsList) {
  return SizedBox(
    // height: 100,
    width: width,
      child: ListView.builder(
      primary: false,
      // physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: commentsList.length,
      itemBuilder: (context, i) {
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "# ${i + 1}",
                  textAlign: TextAlign.left,
                  style: TextStyle(

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 8.0, 8.0, 8.0),
                child: Text(
                  commentsList[i],
                  textAlign: TextAlign.left,
                ),
              )
            ],
          ),
        );
      },
    ),
  );
}
