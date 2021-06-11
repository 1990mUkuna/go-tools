import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/models/services/auth_services.dart';
import 'package:news_app/views/widgets/app_text_field.dart';

class Login extends StatefulWidget {
  static const routeName = '/LoginPage11';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;
  bool _showPassword = false;
  void _toggleShowPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    TextTheme theme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.width / 20,
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: width,
                    height: height,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.green, Colors.green],
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin:
                              const EdgeInsets.only(top: 40.0, bottom: 20.0),
                          height: 80,
                        ),
                        Column(
                          children: [
                            Text(
                              "GooTools",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 40.0),
                        AppTextField(
                          controller: _emailController,
                          hintText: "Email",
                          textInputType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          // labelText: S.of(context).email,
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          style: theme.bodyText1.copyWith(fontSize: 16),
                          controller: _passwordController,
                          obscureText: !_showPassword,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "field Not Left Empty";
                            }
                            return null;
                          },
                          cursorColor: Theme.of(context).primaryColor,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                splashColor: Colors.transparent,
                                padding: const EdgeInsets.only(right: 16),
                                icon: Icon(
                                  _showPassword
                                      ? Icons.remove_red_eye_outlined
                                      : Icons.panorama_fish_eye_sharp,
                                  color: Theme.of(context).primaryColor,
                                ),
                                onPressed: _toggleShowPassword),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 25.0,
                              horizontal: 10.0,
                            ),
                            labelText: "password",
                            hintStyle: theme.bodyText1.copyWith(
                              fontSize: 16,
                              color: Color(0xFF2B2B2B),
                            ),
                            filled: true,
                            fillColor: Color(0xFFf4f4f4),
                          ),
                        ),

                        SizedBox(height: 30.0),
                        SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            color: Colors.white,
                            textColor: Colors.lightBlue,
                            padding: const EdgeInsets.all(20.0),
                            child: Text("Login".toUpperCase()),
                            onPressed: () {
                              if (_emailController.text.isNotEmpty &&
                                  _passwordController.text.isNotEmpty) {
                                setState(() {
                                  isLoading = true;
                                });
                                login(_emailController.text,
                                        _passwordController.text)
                                    .then((user) {
                                  if (user != null) {
                                    print("Login Succesfull");
                                    Navigator.of(context)
                                        .pushNamed("/root-navigator");
                                    setState(() {
                                      isLoading = false;
                                    });
                                  } else {
                                    print("Login Failed");
                                    setState(() {
                                  isLoading = false;
                                });
                                  }
                                });
                              } else {
                                print("Please fill form correctly");
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                              textColor: Colors.white70,
                              child: Text("Create Account".toUpperCase()),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed("/create-accout");
                              },
                            ),
                            Container(
                              color: Colors.white54,
                              width: 2.0,
                              height: 20.0,
                            ),
                            FlatButton(
                              textColor: Colors.white70,
                              child: Text("Forgot Password".toUpperCase()),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        //SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
