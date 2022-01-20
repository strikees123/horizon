// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  getUser(String userName) async {
    final result = await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: userName)
        .get();
    return result.docs.isEmpty;
  }

  confirmUserName(String userName) {
    return FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: userName)
        .snapshots();
  }

  getUserByUserEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: userEmail)
        .get();
  }

  uploadUserInfo(userInfo) {
    FirebaseFirestore.instance.collection("users").add(userInfo);
  }

  geteventNames() {
    return FirebaseFirestore.instance
        .collection("events")
        .where("name")
        .orderBy("name", descending: true)
        .snapshots();
  }

  getMainEventByName(String eventName) {
    return FirebaseFirestore.instance
        .collection("events")
        .doc(eventName)
        .collection("event")
        .orderBy("name", descending: false)
        .snapshots();
  }
}
