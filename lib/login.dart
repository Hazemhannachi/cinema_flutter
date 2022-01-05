import 'dart:convert';
import 'package:cinema_app/register.dart';
import 'package:cinema_app/user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'main.dart';


class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  User user = User("", "");
  String url = "http://192.168.1.14:8081/login";

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Future save() async {
    var res = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': user.email, 'password': user.password}));
    print(res.body);
    if (res.body != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyApp(),
          ));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      // title: Text("Start"),
      //),
        body: Center(
            child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 8.0,
                          child: Container(
                            height: 570.0,
                            width: 340.0,
                            decoration: const BoxDecoration(
                                color: Colors.lightBlue,

                                borderRadius: BorderRadius.all(
                                    Radius.circular(20.0)
                                )
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Login",
                                  style: GoogleFonts.oswald(
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 50.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 50.0,),
                                Container(
                                  width: 300.0,
                                  child: TextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                      hintText: "Enter your email",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 40.0,),
                                Container(
                                  width: 300.0,
                                  child:TextFormField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      hintText: "Enter your password",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 200.0,),
                                InkWell(
                                  child: const Text(
                                    "Sign Up now",
                                    style: TextStyle(
                                      color: Colors.indigo,
                                      fontSize: 18.0,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => Register())
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0,),
                        SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                save();
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MyApp())
                              );
                            },
                            child: Icon(Icons.arrow_forward,color: Colors.white,),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(CircleBorder()),
                                backgroundColor: MaterialStateProperty.all(Colors.red)
                            ),
                          ),
                        )

                      ],

                    )
                )
            )
        )
    );
  }

}