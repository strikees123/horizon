// @dart=2.9
import 'package:flutter/material.dart';
import 'package:horizon/backend/database.dart';
import 'package:horizon/backend/server.dart';
import 'package:horizon/shared_pref/pref_save.dart';
import 'package:horizon/signin/signin.dart';
import 'package:horizon/ui_page/aboustUs.dart';
import 'package:horizon/ui_page/eventPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "", email = "";
  Stream eventStream;
  @override
  void initState() {
    setUserInfo();
    updateStream();
    super.initState();
  }

  updateStream() async {
    setState(() {
      eventStream = Database().geteventNames();
    });
  }

  setUserInfo() async {
    name = await HelperFunctions.getUserNameSharedPreference();
    email = await HelperFunctions.getUserEmailSharedPreference();
    setState(() {});
  }

  Widget eventSnaps(BuildContext context) {
    return StreamBuilder(
        stream: eventStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 18, right: 18),
                      child: Card(
                        elevation: 15,
                        color: Colors.grey.shade100,
                        shadowColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: BuildListTile(
                            snapshot.data.docs[index]["name"],
                            snapshot.data.docs[index]["on"],
                            snapshot.data.docs[index]["due"]),
                      ),
                    );
                  })
              : Container(
                  child: Center(child: CircularProgressIndicator()),
                );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: eventSnaps(context),
      appBar: AppBar(
        title: Text(
          "EventSnap",
          style: TextStyle(fontSize: 19),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
          elevation: 20,
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
                    children: [
                      Text(name != null
                          ? name
                          : Container(
                              child: CircularProgressIndicator(),
                            )),
                      Text(email != null ? email : CircularProgressIndicator())
                    ],
                  )
                ],
              )),
              ListTile(
                title: Text("About EMDC"),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => About()));
                },
              ),
              ListTile(
                title: Text("Logout"),
                onTap: () {
                  Methods().signOut();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                },
              ),
            ],
          )),
    );
  }
}

class BuildListTile extends StatelessWidget {
  final String eventName;
  final String on;
  final String due;
  BuildListTile(this.eventName, this.on, this.due);
  @override
  Widget build(BuildContext context) {
    final Shader linearGradient = LinearGradient(
      colors: <Color>[Colors.blueGrey.shade100, Colors.white],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EventPage(eventName)));
      },
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 14),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.blue.shade300,
              Colors.blueAccent,
              Colors.lightBlue
            ]),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/kec.png'),
                  radius: 27,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventName,
                      style: TextStyle(
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()..shader = linearGradient),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "On: $on",
                      style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          foreground: Paint()..shader = linearGradient),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Due: $due!',
              style: new TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()..shader = linearGradient),
            )
          ],
        ),
      ),
    );
  }
}
