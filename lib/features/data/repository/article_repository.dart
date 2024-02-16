import 'dart:io';

import 'package:dio/dio.dart';
import 'package:test_project/core/constants/constants.dart';
import 'package:test_project/core/resources/data_state.dart';
import 'package:test_project/features/data/data_sources/remote/news_api_service.dart';
import 'package:test_project/features/domain/entities/article.dart';
import 'package:test_project/features/domain/repository/article_repository.dart';

import '../models/article.dart';
import '../data_sources/local/app_database.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;

  ArticleRepositoryImpl(this._newsApiService, this._appDatabase);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {
      final httpResponse = await _newsApiService.getNewsArticles(
          apiKey: apiKey, country: countryKey, category: categoryQuery);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      print(e.error);
      return DataFailed(e);
    }
  }

  @override
  Future<void> deleteArticle(ArticleEntity article) {
    return _appDatabase.articleDao.deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<List<ArticleModel>> getSavedArticles() async {
    return _appDatabase.articleDao.getArticles();
  }

  @override
  Future<void> saveArticle(ArticleEntity article) {
    return _appDatabase.articleDao.insertArticle(ArticleModel.fromEntity(article));
  }
}
