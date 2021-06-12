import 'package:equatable/equatable.dart';

class CountryModel extends Equatable {
  final String country;
  final String slug;
  final String iso2;

  CountryModel({this.country, this.slug, this.iso2});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      country: json["Country"],
      slug: json["Slug"],
      iso2: json["ISO2"],
    );
  }
  Map<String, dynamic> toJson() => {
        "Country": country,
        "Slug": slug,
        "ISO2": iso2,
      };
  @override
  List<Object> get props => [
        country,
        slug,
        iso2,
      ];
}
