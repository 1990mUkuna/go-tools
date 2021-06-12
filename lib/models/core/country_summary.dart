import 'package:equatable/equatable.dart';

class CountrySummaryModel extends Equatable {
  final String country;
  final int confirmed;
  final int death;
  final int recovered;
  final int active;
  final DateTime date;

  CountrySummaryModel(
      {this.country,
      this.confirmed,
      this.death,
      this.recovered,
      this.active,
      this.date});

  factory CountrySummaryModel.fromJson(Map<String, dynamic> json) {
    return CountrySummaryModel(
      country: json["Country"],
      confirmed: json["Confirmed"],
      death: json["Deaths"],
      recovered: json["Recovered"],
      active: json["Active"],
      date: DateTime.parse(json["Date"]),
    );
  }
  @override
  List<Object> get props =>
      [country, confirmed, death, recovered, active, date];
}
