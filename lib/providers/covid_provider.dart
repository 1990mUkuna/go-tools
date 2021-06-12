import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/core/24_news.dart';
import 'package:news_app/models/core/country.dart';
import 'package:news_app/models/core/country_summary.dart';
import 'package:news_app/models/core/global_summary.dart';
import 'package:news_app/models/core/request_error.dart';
import 'package:news_app/models/services/covid_services.dart';
import 'package:news_app/models/services/news.dart';

enum GetNewsStatus {
  NewsNotLoaded,
  NewsRequested,
  NewsLoadSuccess,
  NewsLoadFailure,
}

enum GetGlobalSummaryStatus {
  GlobalSummaryNotLoaded,
  GlobalSummaryRequested,
  GlobalSummaryLoadSuccess,
  GlobalSummaryLoadFailure,
}
enum GetCountrySummaryStatus {
  CountrySummaryNotLoaded,
  CountrySummaryRequested,
  CountrySummaryLoadSuccess,
  CountrySummaryLoadFailure,
}

enum GetCountryListStatus {
  CountryListNotLoaded,
  CountryListRequested,
  CountryListLoadSuccess,
  CountryListLoadFailure,
}

class CovidProvider with ChangeNotifier {
  String _errorMessage;
  String get errorMessage => _errorMessage;

  GetNewsStatus _getNewsStatus = GetNewsStatus.NewsRequested;
  GetGlobalSummaryStatus _getGlobalSummaryStatus =
      GetGlobalSummaryStatus.GlobalSummaryRequested;
  GetCountrySummaryStatus _countrySummaryStatus =
      GetCountrySummaryStatus.CountrySummaryRequested;
  GetCountryListStatus _countryListStatus =
      GetCountryListStatus.CountryListRequested;

  List<Article> _articles = [];
  GlobalSummaryModel _globalSummary;
  List<CountrySummaryModel> _countrySummary = [];
  List<CountryModel> _countries = [];

  GetNewsStatus get getNewsStatus => _getNewsStatus;
  GetGlobalSummaryStatus get getGlobalSummaryStatus => _getGlobalSummaryStatus;
  GetCountrySummaryStatus get getCountrySummaryStatus => _countrySummaryStatus;
  GetCountryListStatus get getCountryListStatus => _countryListStatus;

  List<Article> get article => _articles;
  GlobalSummaryModel get globalSummary => _globalSummary;
  List<CountrySummaryModel> get countriesSummary => _countrySummary;
  List<CountryModel> get countries => _countries;

  final _covidService = CovidServices();

  Future<Either<RequestError, GlobalSummaryModel>> getGlobalSummary() async {
    _getGlobalSummaryStatus = GetGlobalSummaryStatus.GlobalSummaryRequested;
    notifyListeners();

    final response = await _covidService.getGlobalSummary();

    if (response.isRight()) {
      _getGlobalSummaryStatus = GetGlobalSummaryStatus.GlobalSummaryLoadSuccess;
      notifyListeners();
    } else if (response.isLeft()) {
      _getGlobalSummaryStatus = GetGlobalSummaryStatus.GlobalSummaryLoadFailure;
      notifyListeners();
    }

    response.fold((left) {
      _errorMessage = left.message;
      print("LEFT MESSAGE IS $left");
      notifyListeners();
    }, (right) {
      _globalSummary = right;
      notifyListeners();
    });

    return response;
  }

  Future<Either<RequestError, List<CountrySummaryModel>>> getCountrySummary(
      String slug) async {
    _countrySummaryStatus = GetCountrySummaryStatus.CountrySummaryRequested;
    notifyListeners();

    final response = await _covidService.getCountrySummary(slug);

    if (response.isRight()) {
      _countrySummaryStatus = GetCountrySummaryStatus.CountrySummaryLoadSuccess;
      notifyListeners();
    } else if (response.isLeft()) {
      _countrySummaryStatus = GetCountrySummaryStatus.CountrySummaryLoadFailure;
      notifyListeners();
    }

    response.fold((left) {
      _errorMessage = left.message;
      print("LEFT MESSAGE IS $left");
      notifyListeners();
    }, (right) {
      _countrySummary = right;
      notifyListeners();
    });

    return response;
  }

  Future<Either<RequestError, List<CountryModel>>> getCountryList() async {
    _countryListStatus = GetCountryListStatus.CountryListRequested;
    notifyListeners();

    final response = await _covidService.getCountryList();

    if (response.isRight()) {
      _countryListStatus = GetCountryListStatus.CountryListLoadSuccess;
      notifyListeners();
    } else if (response.isLeft()) {
      _countryListStatus = GetCountryListStatus.CountryListLoadFailure;
      notifyListeners();
    }

    response.fold((left) {
      _errorMessage = left.message;
      print("LEFT MESSAGE IS $left");
      notifyListeners();
    }, (right) {
      _countries = right;
      notifyListeners();
    });

    return response;
  }
}
