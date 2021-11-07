import 'package:coffee_brew/models/user.dart';
import 'package:coffee_brew/pages/home/home.dart';
import 'package:coffee_brew/pages/wrapper.dart';
import 'package:coffee_brew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.brown[100],
          primarySwatch: Colors.brown,
          appBarTheme: AppBarTheme(
            color: Colors.brown[400],
            elevation: 0
          )
        ),
      ),
    );
  }
}

