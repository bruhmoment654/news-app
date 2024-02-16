import 'package:test_project/core/usecase/usecase.dart';
import 'package:test_project/features/domain/repository/article_repository.dart';

import '../entities/article.dart';

class SaveArticleUseCase implements UseCase<void, ArticleEntity> {
  final ArticleRepository _articleRepository;

  SaveArticleUseCase(this._articleRepository);

  @override
  Future<void> call({ArticleEntity? params}) {
    return _articleRepository.saveArticle(params!);
  }
}
