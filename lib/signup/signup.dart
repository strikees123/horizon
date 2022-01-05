// @dart=2.9
import 'package:flutter/material.dart';
import 'package:horizon/signin/signin.dart';
import 'package:horizon/backend/database.dart';
import 'package:horizon/backend/server.dart';
import 'package:horizon/ui_page/home_page.dart';
import 'package:horizon/widget.dart';
import 'package:horizon/shared_pref/pref_save.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Database databaseMethods = new Database();
  Methods authMethods = new Methods();

  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  bool validName;

  TextEditingController userNameTextEditingController =
      new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();

  signMeUp() async {
    print("first");
    await databaseMethods
        .getUser(userNameTextEditingController.text)
        .then((val) {
      setState(() {
        validName = val;
        print("validator");
      });
    });
    print("second");
    if (formKey.currentState.validate()) {
      ///collecting user info for Firestore
      Map<String, String> userInfo = {
        "name": userNameTextEditingController.text,
        "email": emailTextEditingController.text
      };

      ///Saving the UserName and Email to shared Preferences
      HelperFunctions.saveUserNameSharedPreference(
          userNameTextEditingController.text);
      HelperFunctions.saveUserEmailSharedPreference(
          emailTextEditingController.text);

      setState(() {
        isLoading = true;
      });
      authMethods
          .signUpWithEmailAndPassword(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((val) {
        ///uploading userinfo to Firestore
        databaseMethods.uploadUserInfo(userInfo);

        ///Saving the user logged In preferences
        HelperFunctions.saveUserLoggedInSharedPreference(true);

        ///To next page
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
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
              ),
            )
          : SingleChildScrollView(
              child: Container(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: EdgeInsets.all(25),
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Image.asset('assets/images/login.png'),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (val) {
                                return val.isEmpty || val.length < 3
                                    ? "Enter a valid username"
                                    : validName
                                        ? null
                                        : "Username already taken";
                              },
                              controller: userNameTextEditingController,
                              decoration: textField(' Username'),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              validator: (val) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val)
                                    ? null
                                    : "Enter a valid e-mail";
                              },
                              controller: emailTextEditingController,
                              decoration: textField(' E-mail'),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              obscureText: true,
                              validator: (val) {
                                return val.length > 6
                                    ? null
                                    : "Please enter 6+ characters";
                              },
                              controller: passwordTextEditingController,
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
                          signMeUp();
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
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
                          'Sign Up with Google',
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
                          Text('Already Have account? '),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignIn(),
                                  ));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                'Sign In Now',
                                style: TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
