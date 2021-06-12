import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SerachUser extends StatefulWidget {
  SerachUser({Key key}) : super(key: key);

  @override
  _SerachUserState createState() => _SerachUserState();
}

class _SerachUserState extends State<SerachUser> {
  final _serachController = TextEditingController();
  bool isLoading = false;
  Map<String, dynamic> userMap;
  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    setState(() {
      isLoading = true;
    });
    await _firestore
        .collection('users')
        .where("email", isEqualTo: _serachController)
        .get()
        .then((user) {
      setState(() {
        userMap = user.docs[0].data();
        isLoading = true;
      });
      print(userMap);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Roms"),
      ),
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.width / 20,
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
              children: [
                SizedBox(
                  height: size.height / 20,
                ),
                Container(
                  height: size.height / 14,
                  width: size.width,
                  alignment: Alignment.center,
                  child: Container(
                    height: size.height / 14,
                    width: size.width / 1.2,
                    child: TextField(
                      controller: _serachController,
                      decoration: InputDecoration(
                          hintText: "Search",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height / 30,
                ),
                ElevatedButton(
                  onPressed: onSearch,
                  child: Text("Search"),
                )
              ],
            ),
    );
  }
}
