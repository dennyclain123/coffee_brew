import 'package:coffee_brew/services/auth.dart';
import 'package:coffee_brew/widgets/loading.dart';
import 'package:flutter/material.dart';
class Register extends StatefulWidget {
  final Function toggleView;
  Register({@required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isLoading = false;
  AuthService authService = AuthService();
  var formkey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  var emailTec = TextEditingController();
  var passwordTec = TextEditingController();
  String error = "";
  @override
  Widget build(BuildContext context) {
    return isLoading ? Loading()
        : Scaffold(
      appBar: AppBar(
        title: Text("Register to Coffee Brew"),
        actions: [
          FlatButton.icon(
            onPressed: ()async{
              widget.toggleView();
            },
            icon: Icon(Icons.person),
            label: Text("Sign in"),
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                TextFormField(
                  validator: (val){
                    if(val.isEmpty){
                      return "Required Field";
                    }
                    if(!val.contains("@")){
                      return "Invaild Email";
                    }
                  },
                  controller: emailTec,
                  onChanged: (val){
                    setState(() {
                      email = val;
                    });
                  },
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: (){
                          emailTec.clear();
                        },
                        icon: Icon(Icons.close),
                      ),
                      hintText: "Email",
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  validator: (val){
                    if(val.isEmpty){
                      return "Required Field";
                    }
                    if(val.length < 6){
                      return "Password must contain at least 6 characters";
                    }
                  },
                  controller: passwordTec,
                  onChanged: (val){
                    setState(() {
                      password = val;
                    });
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: (){
                          passwordTec.clear();
                        },
                        icon: Icon(Icons.close),
                      ),
                      hintText: "Password",
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
                SizedBox(height: 10,),
                RaisedButton(
                  onPressed: ()async{
                    bool isVaild = formkey.currentState.validate();
                    if(!isVaild){
                      return;
                    }
                    setState(() {
                      isLoading = true;
                    });
                    dynamic result = await authService.registerWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        isLoading  = false;
                        error = "Please fill with a valid Email";
                      });
                    }
                  },
                  color: Colors.brown[400],
                  textColor: Colors.white,
                  child: Text("Register"),
                ),
                SizedBox(height: 15,),
                Text(error,style: TextStyle(
                    color: Colors.red
                ),)
              ],
            ),
          )

      ),
    );
  }
}
