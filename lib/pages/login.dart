import 'package:deflon/pages/signup.dart';
import 'package:deflon/pages/welcome.dart';
import 'package:deflon/provider/user_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      resizeToAvoidBottomPadding: true,
      body: user.status == Status.Authenticating ? Loading() : Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.asset('assets/images/goldengate3.jpg',
                fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Color.fromRGBO(24, 24, 45, 0.1), Color.fromRGBO(24, 24, 45, 0.9)])),
              child: ListView(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.35,
                        margin: EdgeInsets.only(top: 30.0),
                        // color: Colors.red[100],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(height: 30.0),
                            Container(    
                              width: 150,
                              child: Image.asset('assets/images/Final.png',
                                fit: BoxFit.fill,
                                ),
                            ),
                            // Icon(Icons.add_location, size: 70.0, color: Colors.white,),
                            Column(
                              children: <Widget>[
                                Text("Let's take that riding experience",
                                style: TextStyle(
                                  color: Color.fromRGBO(24, 24, 45, 1),
                                  fontSize: 16.0,
                                ),),
                                Text("to a whole new level!",
                                style: TextStyle(
                                  color: Color.fromRGBO(24, 24, 45, 1),
                                  fontSize: 20.0,
                                ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        width: double.infinity,
                        // color: Colors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(3.0),
                                      color: Color.fromRGBO(24, 24, 45, 0.5),
                                      elevation: 0.0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 12.0),
                                        child: TextFormField(
                                           controller: _emailTextController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(color: Colors.white),
                                            hintText: "example@email.com",
                                            icon: Icon(Icons.mail, color: Colors.white60,),
                                          ),
                                          validator: (value) {
                                            var response;
                                            if (value.isEmpty) {
                                              Pattern pattern =
                                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                              RegExp regex = new RegExp(pattern);
                                              if (!regex.hasMatch(value))
                                                response =  'Please make sure your email address is valid';
                                            }
                                            return response;
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                                    child: Material(
                                      borderRadius: BorderRadius.circular(3.0),
                                      color: Color.fromRGBO(24, 24, 45, 0.5),
                                      elevation: 0.0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 12.0),
                                        child: TextFormField(
                                          obscureText: true,
                                           controller: _passwordTextController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(color: Colors.white),
                                            hintText: "Password",
                                            icon: Icon(Icons.lock_outline, color: Colors.white60,),
                                          ),
                                          validator: (value) {
                                            var response;
                                            if (value.isEmpty) {
                                              response =  "The password field cannot be empty";
                                            } else if (value.length < 6) {
                                              response = "the password has to be at least 6 characters long";
                                            }
                                            return response;
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                                  child: Material(
                                      borderRadius: BorderRadius.circular(3.0),
                                      color: Color.fromRGBO(24, 24, 45, 1),
                                      elevation: 0.0,
                                      child: MaterialButton(
                                        onPressed: () async{
                                          if(!await user.signIn(_emailTextController.text, _passwordTextController.text))
                                            _key.currentState.showSnackBar(SnackBar(content: Text('Sign in failed'),));
                                        },
                                        minWidth: MediaQuery.of(context).size.width,
                                        child: Text(
                                          "LOGIN",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0),
                                        ),
                                      )),
                                ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(3.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    FlatButton.icon(
                                      icon: Icon(FontAwesomeIcons.facebook,
                                      color: Colors.blue,),
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(
                                          builder: (context) =>Welcome()
                                        ));
                                      },
                                      label: Text('Facebook'),
                                    ),
                                    FlatButton.icon(
                                      icon: Icon(FontAwesomeIcons.google,
                                      color: Colors.blue,),
                                      onPressed: () {},
                                      label: Text('Google'),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                              child: Material(
                                  borderRadius: BorderRadius.circular(3.0),
                                  color: Colors.blue.withOpacity(0.1),
                                  elevation: 0.0,
                                  child: MaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignUp()
                                        ),
                                      );
                                    },
                                    minWidth: MediaQuery.of(context).size.width,
                                    child: Text(
                                      "or sign up for a new account",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20.0),
                                    ),
                                  )),
                            ),
                          ],
                        ),

                      )
                    ],),
                  ],
              ),
            ),
          ),
        ],
      )
    );
  }
}