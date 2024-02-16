import 'package:test_project/core/resources/data_state.dart';
import 'package:test_project/core/usecase/usecase.dart';
import 'package:test_project/features/domain/repository/article_repository.dart';

import '../entities/article.dart';


class GetArticleUseCase implements UseCase<DataState<List<ArticleEntity>>, void> {

  final ArticleRepository _articleRepository;

  GetArticleUseCase(this._articleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    return _articleRepository.getNewsArticles();

  }
}
