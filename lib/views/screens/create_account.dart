import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/models/services/auth_services.dart';
import 'package:news_app/views/widgets/app_text_field.dart';

class CreateAccount extends StatefulWidget {
  static const routeName = '/CreateAccountPage11';

  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
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
                              "Register",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 40.0),
                        AppTextField(
                          controller: _nameController,
                          hintText: "Name",
                          textInputType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          // labelText: S.of(context).email,
                        ),
                        SizedBox(height: 10.0),
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
                            child: Text("CreateAccount".toUpperCase()),
                            onPressed: () {
                              if (_nameController.text.isNotEmpty &&
                                  _emailController.text.isNotEmpty &&
                                  _passwordController.text.isNotEmpty) {
                                setState(() {
                                  isLoading = true;
                                });
                                createAccount(
                                        _nameController.text,
                                        _emailController.text,
                                        _passwordController.text)
                                    .then((user) {
                                  if (user != null) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    print("Create Accout Succesfully");
                                    Navigator.of(context)
                                        .pushNamed("/root-navigator");
                                  } else {
                                    print("Login Failed");
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                });
                              } else {
                                print("Please enter Fields");
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
                              child: Text(
                                  "Already Have \nan Account".toUpperCase()),
                              onPressed: () => Navigator.of(context).pop(),
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
