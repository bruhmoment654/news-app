import 'package:floor/floor.dart';
import 'package:test_project/features/data/models/article.dart';

@dao
abstract class ArticleDao{


  @Insert()
  Future<void> insertArticle(ArticleModel article);

  @delete
  Future<void> deleteArticle(ArticleModel article);

  @Query('select * from article')
  Future<List<ArticleModel>> getArticles();




}