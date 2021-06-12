import 'package:flutter/material.dart';
import 'package:news_app/models/core/global_summary.dart';
import 'package:news_app/providers/covid_provider.dart';
import 'package:news_app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class GlobalStatistics extends StatelessWidget {
  //final GlobalSummaryModel summary;
 // GlobalStatistics({@required this.summary});

  @override
  Widget build(BuildContext context) {
    final covid = Provider.of<CovidProvider>(context, listen: false);
    covid.getGlobalSummary();
    return Column(
      children: <Widget>[
        buildCard("CONFIRMED", covid.globalSummary.totalConfirmed,
            covid.globalSummary.newConfirmed, kConfirmedColor),
        buildCard(
            "ACTIVE",
            covid.globalSummary.totalConfirmed -
                covid.globalSummary.totalRecovered -
                covid.globalSummary.totalDeaths,
            covid.globalSummary.newConfirmed -
                covid.globalSummary.newRecovered -
                covid.globalSummary.newDeaths,
            kActiveColor),
        buildCard("RECOVERED", covid.globalSummary.totalRecovered,
            covid.globalSummary.newRecovered, kRecoveredColor),
        buildCard("DEATH", covid.globalSummary.totalDeaths,
            covid.globalSummary.newDeaths, kDeathColor),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Text(
            "Statistics updated " + timeago.format(covid.globalSummary.date),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCard(String title, int totalCount, int todayCount, Color color) {
    return Card(
      elevation: 1,
      child: Container(
        height: 100,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Expanded(
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Total",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      totalCount.toString().replaceAllMapped(reg, mathFunc),
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Today",
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      todayCount.toString().replaceAllMapped(reg, mathFunc),
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
