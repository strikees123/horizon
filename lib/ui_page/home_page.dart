// @dart=2.9
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("subash")),
      appBar: AppBar(
        title: Text(
          "EventSnap",
          style: TextStyle(fontSize: 19),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              child: Column(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/pngwing.png'),
              )
            ],
          )),
          ListTile(
            title: Text("About Us"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text("Logout"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      )),
    );
  }
}
