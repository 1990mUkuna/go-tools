import 'package:flutter/material.dart';

class AppPillBtn extends StatefulWidget {
  final String label;
  final String value;

  final Function(String) onPillRedirect;

  AppPillBtn({
    @required this.label,
    @required this.value,
    @required this.onPillRedirect,
  });

  @override
  _AppPillBtnState createState() => _AppPillBtnState();
}

class _AppPillBtnState extends State<AppPillBtn> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return GestureDetector(
        onTap: () {
          widget.onPillRedirect(widget.value);
          setState(() {
            isSelected = !isSelected;
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Container(
              height: 150.0,
              child: Column(
                children: [
                  Container(
                    width: 100.0,
                    height: 80.0,
                    child: Card(
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Image.asset("assets/images/phone_icon.png"),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "${widget.label}",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              )),
        ));
  }
}
