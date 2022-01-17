// @dart=2.9
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*For now see database, snapshot transferred and o retreive the event name and registration process
 is pending */
class EventPage extends StatelessWidget {
  final String eventname;
  final QuerySnapshot snapShot;
  EventPage(this.eventname, this.snapShot);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$eventname"),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 30, left: 19, right: 19),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 40, right: 40, top: 40, bottom: 40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        colors: [Colors.blue, Colors.lightBlue, Colors.blue]),
                  ),
                  child: Container(
                    child: Text(
                      "obwe",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: 50, right: 50, top: 40, bottom: 40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        colors: [Colors.blue, Colors.lightBlue, Colors.blue]),
                  ),
                  child: Container(
                    child: Text(
                      "2",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
