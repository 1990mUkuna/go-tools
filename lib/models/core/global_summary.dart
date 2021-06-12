import 'package:equatable/equatable.dart';

class GlobalSummaryModel extends Equatable {
  final int newConfirmed;
  final int totalConfirmed;
  final int newDeaths;
  final int totalDeaths;
  final int newRecovered;
  final int totalRecovered;
  final DateTime date;

  GlobalSummaryModel(
      {this.newConfirmed,
      this.totalConfirmed,
      this.newDeaths,
      this.totalDeaths,
      this.newRecovered,
      this.totalRecovered,
      this.date});

  factory GlobalSummaryModel.fromJson(Map<String, dynamic> json) {
    return GlobalSummaryModel(
      newConfirmed: json["NewConfirmed"],
      totalConfirmed: json["TotalConfirmed"],
      newDeaths: json["NewDeaths"],
      totalDeaths: json["TotalDeaths"],
      newRecovered: json["NewRecovered"],
      totalRecovered: json["TotalRecovered"],
      date: DateTime.parse(json["Date"]),
    );
  }

  @override
  List<Object> get props => [
        newConfirmed,
        totalConfirmed,
        newDeaths,
        totalDeaths,
        newRecovered,
        totalRecovered,
        date
      ];
}
