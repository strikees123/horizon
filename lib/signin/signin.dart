// @dart=2.9
import 'package:flutter/material.dart';
import 'package:horizon/ui_page/home_page.dart';
import 'package:horizon/widget.dart';
import 'package:horizon/shared_pref/pref_save.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:horizon/backend/server.dart';
import 'package:horizon/signup/signup.dart';
import 'package:horizon/backend/database.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Methods authMethods = new Methods();
  Database database = new Database();
  bool isLoading = false;

  final formKey = GlobalKey<FormState>();
  TextEditingController userEmailTextEditingController =
      new TextEditingController();
  TextEditingController userPasswordTextEditingController =
      new TextEditingController();
  QuerySnapshot snapShot;

  signMeIn() {
    if (formKey.currentState.validate()) {
      HelperFunctions.saveUserEmailSharedPreference(
          userEmailTextEditingController.text);
      database
          .getUserByUserEmail(userEmailTextEditingController.text)
          .then((val) {
        snapShot = val;
        HelperFunctions.saveUserNameSharedPreference(snapShot.docs[0]["name"]);
      });
      setState(() {
        isLoading = true;
      });

      authMethods
          .signInWithEmailAndPassword(
              userEmailTextEditingController.text.toString().trim(),
              userPasswordTextEditingController.text.trim())
          .then((val) {
        if (val != null) {
          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: appBarMain(context),
      body: isLoading
          ? Center(
              child: Container(
              child: CircularProgressIndicator(),
            ))
          : SingleChildScrollView(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(26),
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Image.asset('assets/images/login.png'),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (val) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val)
                                    ? null
                                    : "Enter a valid e-mail";
                              },
                              controller: userEmailTextEditingController,
                              decoration: textField(' E-mail'),
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            TextFormField(
                              validator: (val) {
                                return val.length > 6
                                    ? null
                                    : "Enter 6 + characters";
                              },
                              obscureText: true,
                              controller: userPasswordTextEditingController,
                              decoration: textField(' Password'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 21, horizontal: 0),
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'Forget Password?',
                          style: TextStyle(color: Colors.blue.shade400),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          signMeIn();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 18),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.blue.shade400,
                                Colors.blue,
                                Colors.blue.shade400,
                              ]),
                              borderRadius: BorderRadius.circular(26)),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 18),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.red.shade400,
                              Colors.red,
                              Colors.red.shade400,
                            ]),
                            borderRadius: BorderRadius.circular(26)),
                        child: Text(
                          'Sign In with Google',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('New User? '),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUp(),
                                  ));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                'Register Now',
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 85,
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
