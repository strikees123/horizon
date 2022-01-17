// @dart=2.9
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:horizon/backend/database.dart';
import 'package:horizon/backend/server.dart';
import 'package:horizon/shared_pref/pref_save.dart';
import 'package:horizon/signin/signin.dart';
import 'package:horizon/ui_page/aboustUs.dart';

import 'eventPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "", email = "";
  List<String> eventName = ["", ""];
  List<String> eventDate = ["", ""];
  QuerySnapshot snapshot;
  @override
  void initState() {
    setUserInfo();
    getDetails();
    super.initState();
  }

  getDetails() {
    Database().getEventDetails().then((value) {
      setState(() {
        snapshot = value;
        eventName[0] = snapshot.docs[1]["name"];
        eventDate[0] = snapshot.docs[1]["date"];
        eventName[1] = snapshot.docs[0]["name"];
        eventDate[1] = snapshot.docs[0]["date"];
        print(eventName);
      });
    });
  }

  setUserInfo() async {
    name = await HelperFunctions.getUserNameSharedPreference();
    email = await HelperFunctions.getUserEmailSharedPreference();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EventPage(eventName[0],snapshot)));
              },
              child: Card(
                elevation: 12,
                shadowColor: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.blue.shade300,
                        Colors.blueAccent,
                        Colors.blue.shade400
                      ]),
                      borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.only(left: 20, top: 30),
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/kec.png'),
                            radius: MediaQuery.of(context).size.height * 0.07,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                eventName[0],
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Due: ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                eventDate[0],
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 12,
              shadowColor: Colors.lightBlueAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.blue.shade300,
                      Colors.blueAccent,
                      Colors.blue.shade400
                    ]),
                    borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.only(left: 20, top: 30),
                height: MediaQuery.of(context).size.height * 0.2,
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/images/kec.png'),
                          radius: MediaQuery.of(context).size.height * 0.07,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              eventName[1],
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Due: ",
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              eventDate[1],
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/pngwing.png'),
                radius: 34,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(name), Text(email)],
              )
            ],
          )),
          ListTile(
            title: Text("About EMDC"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => About()));
            },
          ),
          ListTile(
            title: Text("Logout"),
            onTap: () {
              Methods().signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => SignIn()));
            },
          ),
        ],
      )),
    );
  }
}
