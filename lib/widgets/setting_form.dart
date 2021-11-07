import 'package:coffee_brew/models/user.dart';
import 'package:coffee_brew/services/database.dart';
import 'package:coffee_brew/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class SettingsForm extends StatefulWidget {

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final List<String> sugars = ["0","1","2","3","4"];
  final List<int> strengths = [100, 200, 300, 400, 500, 600, 700, 800, 900];
  final formkey = GlobalKey<FormState>();
  String currentName;
  String currentSugars;
  num currentStrength;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid??null).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data;
          return Form(
            key: formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Update your brew settings",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 20,),
                TextFormField(
                  initialValue: userData.name,
                  validator: (val) => val.isEmpty? "Required field" : null,
                  onChanged: (str) {
                    setState(() {
                      currentName = str;
                    });
                  },
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
                SizedBox(height: 20,),
                DropdownButtonFormField(
                  value: currentSugars ?? userData.sugars,
                  items: sugars.map((sugar){
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text("$sugar sugars"),
                    );
                  }).toList(),
                  onChanged: (str){
                    currentSugars = str;
                  },
                ),

                SizedBox(height: 20,),
                Slider(
                  value: (currentStrength ?? userData.strength).toDouble(),
                  min: 100,
                  max: 900,
                  divisions: 8,
                  activeColor: Colors.brown[currentStrength ?? userData.strength],
                  inactiveColor: Colors.brown[currentStrength ?? userData.strength],
                  onChanged: (str){
                    setState(() {
                      currentStrength = str.round();
                    });
                  },
                ),
                SizedBox(height: 20,),
                FlatButton(
                  onPressed: ()async{
                    if(formkey.currentState.validate()){
                      await DatabaseService(uid: user.uid).updateUserData(
                        currentSugars ?? userData.sugars,
                        currentName ?? userData.name,
                        currentStrength ?? userData.strength
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Update"),
                  color: Colors.brown[400],
                  textColor: Colors.white,
                )
              ],
            ),
          );
        }else{
          return Loading();
        }
      }
    );
  }
}
