/* c9915e7d5c504194aa8cea6de5c39f50 */
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:news_app/models/core/24_news.dart';
import 'package:news_app/models/core/request_error.dart';

class ArclesServices {
  final _appleArticle =
      "https://newsapi.org/v2/everything?q=apple&from=2021-06-06&to=2021-06-06&sortBy=popularity&apiKey=c9915e7d5c504194aa8cea6de5c39f50";
  final _teslaArticle =
      "https://newsapi.org/v2/everything?q=tesla&from=2021-05-07&sortBy=publishedAt&apiKey=c9915e7d5c504194aa8cea6de5c39f50";
  final _topBusinesHeadline =
      "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=c9915e7d5c504194aa8cea6de5c39f50";
  final _techCruch =
      "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=c9915e7d5c504194aa8cea6de5c39f50";
  final _wallStreetArticle =
      "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=c9915e7d5c504194aa8cea6de5c39f50";

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

  Future<Either<RequestError, List<Article>>> appleAricle() async {
    try {
      final response = await _dio.get(
        _appleArticle,
      );

      final articlesJson = response.data["articles"] as List;

      List<Article> articles =
          articlesJson.map((article) => Article.fromJson(article)).toList();
      print(articles.runtimeType);

      return Right(articles);
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
                  _getErrorMessage(errorJson) ?? "Failed to fetch Articles"),
        );
      } else {
        inspect(err);
        print(err);
        print(err.message);
        return Left(
          RequestError(message: "Failed to fetch Articles"),
        );
      }
    }
  }

  Future<Either<RequestError, List<Article>>> TeslaAricle() async {
    try {
      final response = await _dio.get(
        _teslaArticle,
      );

      final articlesJson = response.data["articles"] as List;

      List<Article> articles =
          articlesJson.map((article) => Article.fromJson(article)).toList();
      print(articles.runtimeType);

      return Right(articles);
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
                  _getErrorMessage(errorJson) ?? "Failed to fetch Articles"),
        );
      } else {
        inspect(err);
        print(err);
        print(err.message);
        return Left(
          RequestError(message: "Failed to fetch Articles"),
        );
      }
    }
  }

  Future<Either<RequestError, List<Article>>> TopBusinessAricle() async {
    try {
      final response = await _dio.get(
        _topBusinesHeadline,
      );

      final articlesJson = response.data["articles"] as List;

      List<Article> articles =
          articlesJson.map((article) => Article.fromJson(article)).toList();
      print(articles.runtimeType);

      return Right(articles);
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
                  _getErrorMessage(errorJson) ?? "Failed to fetch Articles"),
        );
      } else {
        inspect(err);
        print(err);
        print(err.message);
        return Left(
          RequestError(message: "Failed to fetch Articles"),
        );
      }
    }
  }

  Future<Either<RequestError, List<Article>>> TechCruchAricle() async {
    try {
      final response = await _dio.get(
        _techCruch,
      );

      final articlesJson = response.data["articles"] as List;

      List<Article> articles =
          articlesJson.map((article) => Article.fromJson(article)).toList();
      print(articles.runtimeType);

      return Right(articles);
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
                  _getErrorMessage(errorJson) ?? "Failed to fetch Articles"),
        );
      } else {
        inspect(err);
        print(err);
        print(err.message);
        return Left(
          RequestError(message: "Failed to fetch Articles"),
        );
      }
    }
  }

  Future<Either<RequestError, List<Article>>> WallStreet() async {
    try {
      final response = await _dio.get(
        _wallStreetArticle,
      );

      final articlesJson = response.data["articles"] as List;

      List<Article> articles =
          articlesJson.map((article) => Article.fromJson(article)).toList();
      print(articles.runtimeType);

      return Right(articles);
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
                  _getErrorMessage(errorJson) ?? "Failed to fetch Articles"),
        );
      } else {
        inspect(err);
        print(err);
        print(err.message);
        return Left(
          RequestError(message: "Failed to fetch Articles"),
        );
      }
    }
  }
}
