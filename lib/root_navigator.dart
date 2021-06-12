import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/services/auth_services.dart';
import 'package:news_app/views/screens/24_news.dart';
import 'package:news_app/views/screens/covid_dashboard.dart';
import 'package:news_app/views/screens/list_chats.dart';
import 'package:news_app/views/screens/share_my_location.dart';

class RootNavigator extends StatefulWidget {
  RootNavigator({Key key}) : super(key: key);

  @override
  _RootNavigatorState createState() => _RootNavigatorState();
}

class _RootNavigatorState extends State<RootNavigator> {
  int _page = 0;
  
  final List<Widget> _children = [
    CovidDashboard(),
    News24(),
    RoomChats(),
    ShareMyLocation()
  ];

  void onTappedBar(int index) {
    setState(() {
      _page = index;
    });
  }

  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.green,
          type: BottomNavigationBarType.fixed,
          onTap: onTappedBar,
          currentIndex: _page,
          selectedLabelStyle: TextStyle(
            fontSize: 16,
          ),
          showUnselectedLabels: true,
          unselectedLabelStyle: TextStyle(decorationColor: Colors.black),
          unselectedFontSize: 13,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(
                Icons.local_hospital,
                color: Colors.green,
                size: height * 0.03,
              ),
              // backgroundColor:  Colors.white,
              label: 'Covid',
            ),
            BottomNavigationBarItem(
                icon: new Icon(
                  Icons.exposure,
                  color: Colors.green,
                  size: height * 0.03,
                ),
                label: '24 News'),
            BottomNavigationBarItem(
              icon: new Icon(
                Icons.chat,
                color: Colors.green,
                size: height * 0.03,
              ),
              //backgroundColor:  Colors.white,
              label: 'Chats',
            ),
            BottomNavigationBarItem(
              icon: new Icon(
                Icons.location_city,
                size: height * 0.03,
                color: Colors.green,
              ),
              //backgroundColor:  Colors.white,
              label: 'MyLocation',
            ),
            BottomNavigationBarItem(
              icon: InkWell(
                onTap: () {
                  logOut();
                  Navigator.of(context).pushNamed("/");
                },
                child: new Icon(
                  Icons.logout,
                  size: height * 0.03,
                  color: Colors.green,
                ),
              ),
              //backgroundColor:  Colors.white,
              label: 'LogOut',
            ),
          ],
        ),
        body: _children[_page],
      ),
    );
  }
}
