import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/core/24_news.dart';
import 'package:news_app/models/core/request_error.dart';
import 'package:news_app/models/services/news.dart';

enum GetNewsStatus {
  NewsNotLoaded,
  NewsRequested,
  NewsLoadSuccess,
  NewsLoadFailure,
}

class News24CategoryProvider with ChangeNotifier {
  GetNewsStatus _getNewsStatus = GetNewsStatus.NewsRequested;
  String _errorMessage;
  String get errorMessage => _errorMessage;
  String _childErrorMessage;
  String get childErrorMessage => _childErrorMessage;
  List<Article> _articles = [];
  GetNewsStatus get getNewsStatus => _getNewsStatus;
  List<Article> get article => _articles;

  final _articleService = ArclesServices();

  Future<Either<RequestError, List<Article>>> getAppleArticle() async {
    _getNewsStatus = GetNewsStatus.NewsRequested;
    notifyListeners();

    final response = await _articleService.appleAricle();

    if (response.isRight()) {
      _getNewsStatus = GetNewsStatus.NewsLoadSuccess;
      notifyListeners();
    } else if (response.isLeft()) {
      _getNewsStatus = GetNewsStatus.NewsLoadFailure;
      notifyListeners();
    }

    response.fold((left) {
      _errorMessage = left.message;
      print("LEFT MESSAGE IS $left");
      notifyListeners();
    }, (right) {
      _articles = right;
      notifyListeners();
    });

    return response;
  }

  Future<Either<RequestError, List<Article>>> getTechArticle() async {
    _getNewsStatus = GetNewsStatus.NewsRequested;
    notifyListeners();

    final response = await _articleService.TechCruchAricle();

    if (response.isRight()) {
      _getNewsStatus = GetNewsStatus.NewsLoadSuccess;
      notifyListeners();
    } else if (response.isLeft()) {
      _getNewsStatus = GetNewsStatus.NewsLoadFailure;
      notifyListeners();
    }

    response.fold((left) {
      _errorMessage = left.message;
      print("LEFT MESSAGE IS $left");
      notifyListeners();
    }, (right) {
      _articles = right;
      notifyListeners();
    });

    return response;
  }

  Future<Either<RequestError, List<Article>>> getTeslaArticle() async {
    _getNewsStatus = GetNewsStatus.NewsRequested;
    notifyListeners();

    final response = await _articleService.TeslaAricle();

    if (response.isRight()) {
      _getNewsStatus = GetNewsStatus.NewsLoadSuccess;
      notifyListeners();
    } else if (response.isLeft()) {
      _getNewsStatus = GetNewsStatus.NewsLoadFailure;
      notifyListeners();
    }

    response.fold((left) {
      _errorMessage = left.message;
      print("LEFT MESSAGE IS $left");
      notifyListeners();
    }, (right) {
      _articles = right;
      notifyListeners();
    });

    return response;
  }

  Future<Either<RequestError, List<Article>>> getWallStreetArticle() async {
    _getNewsStatus = GetNewsStatus.NewsRequested;
    notifyListeners();

    final response = await _articleService.WallStreet();

    if (response.isRight()) {
      _getNewsStatus = GetNewsStatus.NewsLoadSuccess;
      notifyListeners();
    } else if (response.isLeft()) {
      _getNewsStatus = GetNewsStatus.NewsLoadFailure;
      notifyListeners();
    }

    response.fold((left) {
      _errorMessage = left.message;
      print("LEFT MESSAGE IS $left");
      notifyListeners();
    }, (right) {
      _articles = right;
      notifyListeners();
    });

    return response;
  }
}
