//@dart=2.9
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions{

  static String sharedPreferenceLoggedInKey = "LOGKEY";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";


  ///Saving the credentials of the user through SharedPreferences
  static Future<bool> saveUserLoggedInSharedPreference(bool isUserLoggedIn) async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     return await prefs
         .setBool(sharedPreferenceLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSharedPreference(String userName) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs
        .setString(sharedPreferenceUserNameKey, userName);
  }

  static Future<bool> saveUserEmailSharedPreference(String userEmail) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs
        .setString(sharedPreferenceUserEmailKey, userEmail);
  }

  ///Getting the UserCredentials through SharedPreferences

  static Future<bool> getUserLoggedInSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getBool(sharedPreferenceLoggedInKey);
  }

  static Future<String> getUserNameSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getString(sharedPreferenceUserNameKey);
  }

  static Future<String> getUserEmailSharedPreference() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getString(sharedPreferenceUserEmailKey);
  }

}