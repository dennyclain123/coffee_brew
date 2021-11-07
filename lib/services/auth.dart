import 'package:coffee_brew/models/user.dart';
import 'package:coffee_brew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coffee_brew/models/user.dart';
class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //create user object based on FirebaseUser
  FirebaseUser userFromFirebaseUser(User user) {
    return user != null ? FirebaseUser(uid: user.uid) : null;
  }
  //auth change user stream
  Stream<FirebaseUser> get user{
    return _auth.authStateChanges().map(userFromFirebaseUser);
  }
  //SignIn Anonymously
  Future signInAnonymous()async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  //SignIn with Email and Password
  Future signInEmailAndPass(String email, String password)async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //Register with Email and Password
  Future registerWithEmailAndPassword(String email, String password)async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      //create a new document for the user with uid
      await DatabaseService(uid: user.uid).updateUserData("0", "new customer", 100);
      return userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //Signout
  Future signOut()async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }


}