// @dart=2.9
import 'package:horizon/string/stringCon.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Methods{
  FirebaseAuth _auth = FirebaseAuth.instance;
  UserIdget _firebaseuserUser(User user){
    return user != null ? UserIdget(userId: user.uid):null;
  }

  Future signInWithEmailAndPassword(String email,String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User firebaseUser = result.user;
      return _firebaseuserUser(firebaseUser);
    }catch(e){
      print(e.toString());
    }
  }

  Future signUpWithEmailAndPassword(String email,String password) async{
      try{
        UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        User firebaseUser = result.user;
        return _firebaseuserUser(firebaseUser);
      }catch(e){
        print(e.toString());
      }
  }

  Future forgetPassword(String email) async{
    try{
      await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
    }
  }
  Future signOut() async{
    try{
      await _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }
}