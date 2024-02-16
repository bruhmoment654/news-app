import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/core/resources/data_state.dart';
import 'package:test_project/features/domain/usecases/article_usecase.dart';
import 'package:test_project/features/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:test_project/features/presentation/bloc/article/remote/remote_article_state.dart';

class RemoteArticlesBloc extends Bloc<RemoteArticlesEvent, RemoteArticleState> {
  final GetArticleUseCase _getArticlesUseCase;

  RemoteArticlesBloc(this._getArticlesUseCase)
      : super(const RemoteArticlesLoading()) {
    on<GetArticles>(onGetArticles);
  }

  void onGetArticles(
      GetArticles event, Emitter<RemoteArticleState> emit) async {
    final dataState = await _getArticlesUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticlesDone(dataState.data!));
    }

    if (dataState is DataFailed || dataState.data!.isEmpty) {
      emit(RemoteArticlesError(dataState.exception!));
    }
  }
}
