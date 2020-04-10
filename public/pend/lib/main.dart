import 'package:flutter/material.dart';
import 'package:pend/UI/HomePage.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      title: "Pend",
      theme: ThemeData(
        fontFamily: "Ubuntu",
      ),

      home: HomePage(
        title: "Dance Monkey",
        contentOfText: "They say oh my god I see the way you shine \nTake your hand, my dear, and place them both in mine \n You know you stopped me dead while I was passing by \n And now I beg to see you dance just one more time",
        author: "Shobhit",
        following: true,
        drumRolls: 20,
        commentsOfText: "List", // list 
        readersChoice: true,
        bookmarked: false,
      ),
    );
  }
}