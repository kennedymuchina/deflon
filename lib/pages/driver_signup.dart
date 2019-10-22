import 'package:deflon/pages/login.dart';
import 'package:deflon/provider/user_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DriverSignUp extends StatefulWidget {
  @override
  _DriverSignUpState createState() => _DriverSignUpState();
}

class _DriverSignUpState extends State<DriverSignUp> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        // color: Colors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 160,),
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
                                           controller: _nameTextController,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(color: Colors.yellow),
                                            hintText: "name",
                                            icon: Icon(Icons.person_outline, color: Colors.yellow,),
                                          ),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "The name field cannot be empty";
                                            } else if (value.length < 3) {
                                              return "The name has to be at least 3 characters long";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
//                                  Padding(
//                                    padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
//                                    child: Material(
//                                      borderRadius: BorderRadius.circular(3.0),
//                                      color: Colors.blue.withOpacity(0.5),
//                                      elevation: 0.0,
//                                      child: Padding(
//                                        padding: const EdgeInsets.only(left: 12.0),
//                                        child: TextFormField(
//                                          // controller: _emailTextController,
//                                          decoration: InputDecoration(
//                                            border: InputBorder.none,
//                                            hintStyle: TextStyle(color: Colors.white),
//                                            hintText: "0701345678",
//                                            icon: Icon(Icons.phone, color: Colors.white60,),
//                                          ),
//                                          validator: (value) {
//                                            if (value.isEmpty) {
//                                              Pattern pattern =
//                                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//                                              RegExp regex = new RegExp(pattern);
//                                              if (!regex.hasMatch(value))
//                                                return 'Please make sure your phone number is valid';
//                                              else
//                                                return null;
//                                            }
//                                          },
//                                        ),
//                                      ),
//                                    ),
//                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
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
                                            hintStyle: TextStyle(color: Colors.yellow),
                                            hintText: "example@email.com",
                                            icon: Icon(Icons.mail, color: Colors.yellow,),
                                          ),
                                          validator: (value) {
                                            var response;
                                            if (value.isEmpty) {
                                              Pattern pattern =
                                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                              RegExp regex = new RegExp(pattern);
                                              if (!regex.hasMatch(value))
                                                response = 'Please make sure your email address is valid';
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
                                            hintStyle: TextStyle(color: Colors.yellow),
                                            hintText: "Password",
                                            icon: Icon(Icons.lock_outline, color: Colors.yellow,),
                                          ),
                                          validator: (value) {
                                            var response;
                                            if (value.isEmpty) {
                                              response = "The password field cannot be empty";
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
                                      color: Color.fromRGBO(24, 24, 45, 0.9),
                                      elevation: 0.0,
                                      child: MaterialButton(
                                        onPressed: () async{
                                          if(_formKey.currentState.validate()){
                                            if(!await user.signUp(_nameTextController.text, _emailTextController.text, _passwordTextController.text))
                                              _key.currentState.showSnackBar(SnackBar(content: Container(
                                              height: 30.0,
                                              width: MediaQuery.of(context).size.width * 0.9,
                                              child: Center(child: Text('Sign in failed')))));
                                          }
                                        },
                                        minWidth: MediaQuery.of(context).size.width,
                                        child: Text(
                                          "SIGNUP",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.yellow,
                                              fontWeight: FontWeight.w400,
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
                                      onPressed: () {},
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
                                          builder: (context) => Login()
                                        ),
                                      );
                                    },
                                    minWidth: MediaQuery.of(context).size.width,
                                    child: Text(
                                      "or back to the login page",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300,
                                          fontSize: 20.0),
                                    ),
                                  )),
                            )
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


class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        color: Colors.white.withOpacity(0.2),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
        ),
      ),
    );
  }
}
