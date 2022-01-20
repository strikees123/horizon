// @dart=2.9
import 'package:flutter/material.dart';
import 'package:horizon/ui_page/resgistration.dart';

class EventDetails extends StatefulWidget {
  final String eventName;
  final String about;
  final String eventTitle;
  EventDetails(this.about, this.eventName, this.eventTitle);
  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.eventName),
      ),
      body: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                widget.about,
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Registration(widget.eventName,widget.eventTitle)));
              },
              child: Material(
                elevation: 12,
                borderRadius: BorderRadius.circular(20),
                shadowColor: Colors.blue.shade200,
                child: Container(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 17, bottom: 17),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(colors: [
                      Colors.purpleAccent.shade400,
                      Colors.blue,
                    ]),
                  ),
                  child: Text(
                    "Register",
                    style: TextStyle(
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
