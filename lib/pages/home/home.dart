import 'package:coffee_brew/models/brew.dart';
import 'package:coffee_brew/widgets/brewList.dart';
import 'package:coffee_brew/services/auth.dart';
import 'package:coffee_brew/services/database.dart';
import 'package:coffee_brew/widgets/setting_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService authService = AuthService();
  void showBottomBar(){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 60),
          child: SettingsForm()
        );
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
      initialData: [],
      value: DatabaseService().brews,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          actions: [
            FlatButton.icon(
              onPressed: ()async{
               await authService.signOut();
              },
              icon: Icon(Icons.person),
              label: Text("Logout"),
            ),
            FlatButton.icon(
              onPressed: () => showBottomBar(),
              icon: Icon(Icons.settings),
              label: Text("Settings"),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/coffee_bg.png')
            )
          ),
            child: DatabaseService().brews == null ? Container(): BrewList()
        )
      ),
    );
  }
}
