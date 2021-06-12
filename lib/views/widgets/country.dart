import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:news_app/models/core/country.dart';
import 'package:news_app/models/core/country_summary.dart';
import 'package:news_app/providers/covid_provider.dart';
import 'package:provider/provider.dart';

import 'country_loading.dart';
import 'country_statics.dart';

class Country extends StatefulWidget {
  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {
  final TextEditingController _typeAheadController = TextEditingController();
  Future<List<CountryModel>> countryList;
  Future<List<CountrySummaryModel>> summaryList;
  @override
  initState() {
    super.initState();
    final covid = Provider.of<CovidProvider>(context, listen: false);
    covid.getCountrySummary("united-states");
    inspect(covid.getGlobalSummary());
  }

  List<String> _getSuggestions(List<CountryModel> list, String query) {
    List<String> matches = List();

    for (var item in list) {
      matches.add(item.country);
    }

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  @override
  Widget build(BuildContext context) {
    final covid = Provider.of<CovidProvider>(context, listen: false);

    return SingleChildScrollView(
      child: FutureBuilder(
        future: covid.getCountryList(),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Center(
              child: Text("Error"),
            );
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CountryLoading(inputTextLoading: true);
            default:
              return !snapshot.hasData
                  ? Center(
                      child: Text("Empty"),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                          child: Text(
                            "Country name",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        TypeAheadFormField(
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: this._typeAheadController,
                            decoration: InputDecoration(
                              hintText: 'Type country name',
                              hintStyle: TextStyle(fontSize: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                              contentPadding: EdgeInsets.all(20),
                              prefixIcon: Padding(
                                padding:
                                    EdgeInsets.only(left: 24.0, right: 16.0),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                  size: 28,
                                ),
                              ),
                            ),
                          ),
                          suggestionsCallback: (pattern) {
                            return _getSuggestions(snapshot.data, pattern);
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                              title: Text(suggestion),
                            );
                          },
                          transitionBuilder:
                              (context, suggestionsBox, controller) {
                            return suggestionsBox;
                          },
                          onSuggestionSelected: (suggestion) {
                            this._typeAheadController.text = suggestion;
                            setState(() {
                              covid.getCountrySummary(snapshot.data
                                  .firstWhere((element) =>
                                      element.country == suggestion)
                                  .slug);
                            });
                          },
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        FutureBuilder(
                          future: summaryList,
                          builder: (context, snapshot) {
                            if (snapshot.hasError)
                              return Center(
                                child: Text("Error"),
                              );
                            switch (snapshot.connectionState) {
                              case ConnectionState.waiting:
                                return CountryLoading(inputTextLoading: false);
                              default:
                                return !snapshot.hasData
                                    ? Center(
                                        child: Text("Empty"),
                                      )
                                    : CountryStatistics();
                            }
                          },
                        ),
                      ],
                    );
          }
        },
      ),
    );
  }
}
