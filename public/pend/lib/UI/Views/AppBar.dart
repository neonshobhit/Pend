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
        // onPressed: () {
        //   menuItem(conx);
        // },
      )
    ],
  );
}

menuItem(conx) {
  return PopupMenuButton(
    tooltip: "Account",
    icon: Icon(Icons.person),
    offset: Offset.zero,
    itemBuilder: (conx) {
      var list = List<PopupMenuEntry<Object>>();

      list.add(
        PopupMenuItem(
          child: ListTile(
            leading: IconButton(
              icon: Icon(
                Icons.home,
              ),
              onPressed: () {},
            ),
            title: Text(
              "Profile",
            ),
          ),

          value: 1,
        ),
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
