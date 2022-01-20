// @dart=2.9
import 'package:flutter/material.dart';
import 'package:horizon/backend/database.dart';
import 'package:horizon/ui_page/eventDetails.dart';

class EventPage extends StatefulWidget {
  final String name;
  EventPage(this.name);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  Stream eventNameStream;

  @override
  void initState() {
    getDetails();
    super.initState();
  }

  getDetails() async {
    setState(() {
      eventNameStream = Database().getMainEventByName(widget.name);
    });
  }

  Widget eventName(BuildContext context) {
    return StreamBuilder(
      stream: eventNameStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 10),
                    child: Card(
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26)),
                      child: BuildEventName(
                        snapshot.data.docs[index]["name"],
                        snapshot.data.docs[index]["about"],
                        widget.name,
                      ),
                    ),
                  );
                },
              )
            : Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: eventName(context),
    );
  }
}

class BuildEventName extends StatefulWidget {
  final String mainEvent;
  final String about;
  final String eventTitle;
  BuildEventName(this.mainEvent, this.about,this.eventTitle);
  @override
  _BuildEventNameState createState() => _BuildEventNameState();
}

class _BuildEventNameState extends State<BuildEventName> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    EventDetails(widget.about, widget.mainEvent,widget.eventTitle)));
      },
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(26),
        shadowColor: Colors.blue,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                gradient: LinearGradient(colors: [
                  Colors.lightGreen,
                  Colors.blue,
                  Colors.redAccent
                ])),
            padding: EdgeInsets.only(top: 30, bottom: 30),
            child: Column(
              children: [
                Center(
                    child: Text(
                  widget.mainEvent,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
              ],
            )),
      ),
    );
  }
}
