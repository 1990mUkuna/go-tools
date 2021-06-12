import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_app/providers/covid_provider.dart';
import 'package:provider/provider.dart';

import 'global_loading.dart';
import 'global_statics.dart';

class Global extends StatefulWidget {
  @override
  _GlobalState createState() => _GlobalState();
}

class _GlobalState extends State<Global> {
  @override
  initState() {
    super.initState();
    final covid = Provider.of<CovidProvider>(context, listen: false);
    covid.getGlobalSummary();
    //covid.getCountrySummary(slug);
    covid.getCountryList();
    print(covid.getCountryList());
    inspect(covid.getGlobalSummary());
  }

  @override
  Widget build(BuildContext context) {
    final covid = Provider.of<CovidProvider>(context, listen: false);
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Global Corona Virus Cases",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    covid.getGlobalSummary();
                  });
                },
                child: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        FutureBuilder(
          future: covid.getGlobalSummary(),
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Center(
                child: Text("Error"),
              );
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return GlobalLoading();
              default:
                return !snapshot.hasData
                    ? Center(
                        child: Text("Empty"),
                      )
                    : GlobalStatistics(
                        //summary: snapshot.data,
                        );
            }
          },
        ),
      ],
    ));
  }
}
