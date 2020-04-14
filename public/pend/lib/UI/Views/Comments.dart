import 'package:flutter/material.dart';

Widget comments(conx, width, commentsList) {
  final ValueNotifier<List<String>> val =
      ValueNotifier<List<String>>(commentsList);

  return SizedBox(
    // height: 100,
    width: width,
    child: Column(
      children: <Widget>[
        ValueListenableBuilder<List<String>>(
          valueListenable: val,
          builder: (context, value, child) {
            return ListView.builder(
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
                          style: TextStyle(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24.0, 8.0, 8.0, 8.0),
                        child: Text(
                          commentsList[i],
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            enabled: true,
            enableInteractiveSelection: true,
            maxLength: null,
            decoration: InputDecoration(
              hintText: "Comment",
              fillColor: Colors.blue,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.green
                )
              )
            ),
            onSubmitted: (value) {
              commentsList.add(value);
              val.value += commentsList;
              addComment(commentsList);
            },
          ),
        ),
      ],
    ),
  );
}

addComment(val) {}
