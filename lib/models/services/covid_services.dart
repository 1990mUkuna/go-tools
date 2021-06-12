/* c9915e7d5c504194aa8cea6de5c39f50 */
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:news_app/models/core/24_news.dart';
import 'package:news_app/models/core/country.dart';
import 'package:news_app/models/core/country_summary.dart';
import 'package:news_app/models/core/global_summary.dart';
import 'package:news_app/models/core/request_error.dart';

class CovidServices {
  Dio _dio = Dio();

  String _getErrorMessage(Map<String, dynamic> data) {
    if (data["errors"] == null) {
      return data["message"];
    }

    inspect(data);
    inspect(data["errors"]);
    print(data["errors"]);
    inspect(data["errors"]);

    List<String> keys = data["errors"].keys.toList();
    inspect(keys);

    return data["errors"][keys[0]][0];
  }

  Future<Either<RequestError, GlobalSummaryModel>> getGlobalSummary() async {
    try {
      final response = await _dio.get("https://api.covid19api.com/summary");

      final summaryJson = response.data["Global"];
      final summary = GlobalSummaryModel.fromJson(summaryJson);

      return Right(summary);
    } on SocketException catch (_) {
      return Left(
        RequestError(message: "No Internet Connection"),
      );
    } catch (err) {
      inspect(err);
      if (err is DioError) {
        inspect(err);
        final errorJson = jsonDecode(err.response.data);

        print(err);
        print(err.response);
        print(err.message);

        return Left(
          RequestError(
              message: _getErrorMessage(errorJson) ??
                  "Failed to fetch GlobalSummary"),
        );
      } else {
        inspect(err);
        print(err);
        print(err.message);
        return Left(
          RequestError(message: "Failed to fetch GlobalSummary result"),
        );
      }
    }
  }

  Future<Either<RequestError, List<CountrySummaryModel>>> getCountrySummary(
      String slug) async {
    try {
      final response = await _dio.get(
        "https://api.covid19api.com/total/dayone/country/" + slug,
      );

      final countryJson = response.data as List;

      List<CountrySummaryModel> countries = countryJson
          .map((country) => CountrySummaryModel.fromJson(country))
          .toList();
      print(countries.runtimeType);

      return Right(countries);
    } on SocketException catch (_) {
      return Left(
        RequestError(message: "No Internet Connection"),
      );
    } catch (err) {
      inspect(err);
      if (err is DioError) {
        inspect(err);
        final errorJson = jsonDecode(err.response.data);

        print(err);
        print(err.response);
        print(err.message);

        return Left(
          RequestError(
              message: _getErrorMessage(errorJson) ??
                  "Failed to fetch country summary"),
        );
      } else {
        inspect(err);
        print(err);
        print(err.message);
        return Left(
          RequestError(message: "Failed to fetch country summary"),
        );
      }
    }
  }

  Future<Either<RequestError, List<CountryModel>>> getCountryList() async {
    try {
      final response = await _dio.get(
        "https://api.covid19api.com/countries",
      );

      final countryJson = response.data as List;

      List<CountryModel> countries =
          countryJson.map((country) => CountryModel.fromJson(country)).toList();
      print(countries.runtimeType);

      return Right(countries);
    } on SocketException catch (_) {
      return Left(
        RequestError(message: "No Internet Connection"),
      );
    } catch (err) {
      inspect(err);
      if (err is DioError) {
        inspect(err);
        final errorJson = jsonDecode(err.response.data);

        print(err);
        print(err.response);
        print(err.message);

        return Left(
          RequestError(
              message:
                  _getErrorMessage(errorJson) ?? "Failed to fetch countries"),
        );
      } else {
        inspect(err);
        print(err);
        print(err.message);
        return Left(
          RequestError(message: "Failed to fetch countries list"),
        );
      }
    }
  }
}
