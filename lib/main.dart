import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/providers/24_news.dart';
import 'package:news_app/providers/covid_provider.dart';
import 'package:news_app/root_navigator.dart';
import 'package:news_app/views/screens/create_account.dart';
import 'package:news_app/views/screens/keep_authaticated_login.dart';
import 'package:news_app/views/screens/login.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Color primaryColor = Color(0xFFffc55c);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => News24CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CovidProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          "/": (context) => Login(),
          //"/": (context) => KeepUserLogin(),
          "/create-accout": (context) => CreateAccount(),
          "/root-navigator": (context) => RootNavigator(),
        },
      ),
    );
  }
}
