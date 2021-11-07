import 'package:coffee_brew/models/user.dart';
import 'package:coffee_brew/pages/authenticate/authenticate.dart';
import 'package:coffee_brew/pages/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/order.dart';
class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user  = Provider.of<FirebaseUser>(context);
    if(user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}
