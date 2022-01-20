// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:horizon/backend/database.dart';
import 'package:horizon/ui_page/home_page.dart';

class Registration extends StatefulWidget {
  final String eventName;
  final String eventTitle;
  Registration(this.eventName, this.eventTitle);
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final formKey = GlobalKey<FormState>();
  TextEditingController userName = new TextEditingController();
  TextEditingController year = new TextEditingController();
  TextEditingController dep = new TextEditingController();
  TextEditingController number = new TextEditingController();
  TextEditingController rollNo = new TextEditingController();
  TextEditingController email = new TextEditingController();
  
  final snackBar = SnackBar(content: Text("Registered successfully"));
  uploadDetails() {
    if (formKey.currentState.validate()) {
      Map<String, dynamic> detailsMap = {
        "name": userName.text,
        "year": year.text,
        "rollno": rollNo.text,
        "number": number.text,
        "dep": dep.text,
        "eventname": widget.eventName,
        "eventtitle": widget.eventTitle,
        "email": email.text,
      };
      Database().addDetails(detailsMap);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.eventName),
        leading: BackButton(
          onPressed: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage())),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Material(
                      elevation: 2,
                      shadowColor: Colors.blue.shade200,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: TextFormField(
                          validator: (val) {
                            return val == "" ? "Fill this Field" : null;
                          },
                          controller: userName,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2.0)),
                              hintText: "Name",
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Material(
                      elevation: 2,
                      shadowColor: Colors.blue.shade200,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: TextFormField(
                          validator: (val) {
                            return val == "" ? "Fill this Field" : null;
                          },
                          controller: dep,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.school),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2.0)),
                              hintText: "Department",
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Material(
                      elevation: 2,
                      shadowColor: Colors.blue.shade200,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: TextFormField(
                          validator: (val) {
                            return val == "" ? "Fill this Field" : null;
                          },
                          controller: year,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.view_agenda_sharp),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2.0)),
                              hintText: "Year",
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Material(
                      elevation: 2,
                      shadowColor: Colors.blue.shade200,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: TextFormField(
                          validator: (val) {
                            return val == "" ? "Fill this Field" : null;
                          },
                          controller: rollNo,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.badge_sharp),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2.0)),
                              hintText: "Roll No",
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Material(
                      elevation: 2,
                      shadowColor: Colors.blue.shade200,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: TextFormField(
                          validator: (val) {
                            return val == "" ? "Fill this Field" : null;
                          },
                          keyboardType: TextInputType.number,
                          controller: email,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2.0)),
                              hintText: "valid email",
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Material(
                      elevation: 2,
                      shadowColor: Colors.blue.shade200,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: TextFormField(
                          validator: (val) {
                            return val == "" ? "Fill this Field" : null;
                          },
                          keyboardType: TextInputType.number,
                          controller: number,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                      color: Colors.blue, width: 2.0)),
                              hintText: "Phone No",
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              GestureDetector(
                onTap: () {
                  uploadDetails();
                },
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            colors: [Colors.purple.shade300, Colors.blue])),
                    padding: EdgeInsets.only(
                        left: 22, right: 22, top: 12, bottom: 12),
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
