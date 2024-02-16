import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/article.dart';

sealed class RemoteArticleState extends Equatable {
  final List<ArticleEntity>? articles;
  final DioException? exception;

  const RemoteArticleState({this.articles, this.exception});

  @override
  List<Object> get props => [articles!, exception!];
}

class RemoteArticlesLoading extends RemoteArticleState {
  const RemoteArticlesLoading();
}

class RemoteArticlesDone extends RemoteArticleState {
  const RemoteArticlesDone(List<ArticleEntity> articles)
      : super(articles: articles);
}

class RemoteArticlesError extends RemoteArticleState {
  const RemoteArticlesError(DioException exception)
      : super(exception: exception);
}
