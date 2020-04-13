import 'package:flutter/material.dart';

Widget appBar(conx) {
  return AppBar(
    // backgroundColor: Colors.transparent,
    title: Text(
      "Pend",
    ),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 40.0),
        child: menuItem(conx),
      )
    ],
  );
}

menuItem(conx) {
  return PopupMenuButton(
    tooltip: "Account",
    icon: Icon(
      Icons.person,
    ),
    offset: Offset.zero,
    itemBuilder: (conx) {
      var list = List<PopupMenuEntry<Object>>();
      int x = 1;
      popupMenuItem(thatIcon, thatString, thatCallback) => PopupMenuItem(
            child: ListTile(
              leading: IconButton(
                icon: Icon(
                  thatIcon,
                ),
                onPressed: thatCallback,
              ),
              title: Text(
                thatString,
              ),
            ),
            value: x++,
          );
      list.add(
        popupMenuItem(Icons.home, "Profile", () {}),
      );

      list.add(
        popupMenuItem(Icons.collections_bookmark, "Bookmarks", () {}),
      );

      list.add(
        popupMenuItem(Icons.time_to_leave, "Time to leave", () {}),
      );

      return list;
    },
    onSelected: (value) {
      print(value);
    },
    onCanceled: () {
      print("Cancelled");
    },
  );
}
