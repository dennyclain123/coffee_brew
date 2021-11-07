import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_brew/models/brew.dart';
import 'package:coffee_brew/models/user.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');
  Future updateUserData(String sugars,String name, int strength)async{
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength
    });
  }
  //user data from snapshot
  UserData userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: (snapshot.data() as dynamic)['name'],
      sugars: (snapshot.data() as dynamic)['sugars'],
      strength: (snapshot.data() as dynamic)['strength'],
    );
  }
  //brew lists from snapshot
  List<Brew> brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
     return Brew(
       name: (doc.data() as dynamic)['name'] ?? '',
       sugars: (doc.data() as dynamic)['sugars'] ?? '0',
       strength: (doc.data() as dynamic)['strength'] ?? 0
     );

    }).toList();
  }
  //get brews stream
  Stream<List<Brew>> get brews{
    return brewCollection.snapshots().map(brewListFromSnapshot);
  }
  //get user document stream
  Stream<UserData> get userData{
    return brewCollection.doc(uid).snapshots().map(userDataFromSnapshot);
  }
}