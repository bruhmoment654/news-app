import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:test_project/features/data/data_sources/local/app_database.dart';
import 'package:test_project/features/data/data_sources/remote/news_api_service.dart';
import 'package:test_project/features/data/repository/article_repository.dart';
import 'package:test_project/features/domain/repository/article_repository.dart';
import 'package:test_project/features/domain/usecases/article_usecase.dart';
import 'package:test_project/features/domain/usecases/get_saved_article.dart';
import 'package:test_project/features/domain/usecases/remove_article.dart';
import 'package:test_project/features/domain/usecases/save_article.dart';
import 'package:test_project/features/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:test_project/features/presentation/bloc/article/remote/remote_article_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final db = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(db);

  sl.registerSingleton<Dio>(Dio());

  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl(), sl()));

  sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl()));

  sl.registerFactory<RemoteArticlesBloc>(() => RemoteArticlesBloc(sl()));

  sl.registerSingleton<RemoveArticleUseCase>(RemoveArticleUseCase(sl()));
  sl.registerSingleton<SaveArticleUseCase>(SaveArticleUseCase(sl()));
  sl.registerSingleton<GetSavedArticleUseCase>(GetSavedArticleUseCase(sl()));

  sl.registerFactory<LocalArticleBloc>(() => LocalArticleBloc(sl(), sl(), sl()));
}
