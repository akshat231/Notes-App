import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/screens/loginscreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../auth.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var show = false;

  String Email='';
  String Password='';
  String fname='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(0.8, 1),
                    colors: <Color>[
                      Color(0xff1525347),
                      Color(0xff1E2E3D),
                      Color(0xff101D2B),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40.0,
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Register for Your Account',
                        style: TextStyle(
                            fontFamily: 'Mogra',
                            fontWeight: FontWeight.bold,
                            fontSize: 40),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Fill The form',
                        style: TextStyle(
                            fontFamily: 'Mogra',
                            fontWeight: FontWeight.normal,
                            fontSize: 20),
                      ),
                    ),
                  ],
                )),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Color.fromRGBO(255, 255, 255, 1),
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 25.0,
                          ),
                          SizedBox(
                            width: 250.0,
                            child: TextField(
                              onChanged: (value)
                              {
                                setState(() {
                                  fname=value;
                                });
                              },
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: 'Mogra',
                              ),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                                labelText: 'Full Name',
                                labelStyle: TextStyle(
                                  color: Colors.deepPurpleAccent,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          SizedBox(
                            width: 250.0,
                            child: TextField(
                              onChanged: (value)
                              {
                                setState(() {
                                  Email=value;
                                });
                              },
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: 'Mogra',
                              ),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                  color: Colors.deepPurpleAccent,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          SizedBox(
                            width: 250.0,
                            child: TextField(
                             onChanged: (value)
                              {
                                setState(() {
                                  Password=value;
                                });
                              },
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: 'Mogra',
                              ),
                              obscureText: !show,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                                labelText: ' Password',
                                labelStyle: TextStyle(
                                  color: Colors.deepPurpleAccent,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(show
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      show = !show;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Container(
                            height: 50,
                            color: Colors.green.shade500,
                            width: 200,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.green.shade500)),
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                    fontFamily: 'Mogra', color: Colors.black),
                              ),
                              onPressed: () async{
                                if(Email==''||Password==''||fname=='')
                                {
                                  Authorization.handleError("Null Value", context);
                                }
                                else{
                                  await Authorization.emailpasswordcreate(Email, Password, context, fname);
                                  }
                              }
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Divider(
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Or Login With',
                                style: TextStyle(
                                    fontFamily: 'Mogra',
                                    fontSize: 10.0,
                                    color: Colors.black),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white70),
                                    ),
                                    onPressed: () async {
                                     
                                      await Authorization.googlesignin(context);
                                    },
                                    child: Row(
                                      children: [
                                        Image(
                                          image:
                                              AssetImage('images/7611770.png'),
                                          width: 20.0,
                                          height: 40.0,
                                        ),
                                        Text(
                                          'Google',
                                          style: TextStyle(
                                            fontFamily: 'Mogra',
                                            fontSize: 20,
                                            color: Colors.purple.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 90.0,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white70),
                                    ),
                                    onPressed: () async {
                                    
                                      await Authorization.fbsignin(context);
                                    },
                                    child: Row(
                                      children: [
                                        Image(
                                          image: AssetImage('images/fb.png'),
                                          width: 20.0,
                                          height: 40.0,
                                        ),
                                        Text(
                                          'FaceBook',
                                          style: TextStyle(
                                            fontFamily: 'Mogra',
                                            fontSize: 20,
                                            color: Colors.purple.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Center(
                            child: Divider(
                              thickness: 5.0,
                              color: Colors.black,
                              indent: 100.0,
                              endIndent: 100.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
