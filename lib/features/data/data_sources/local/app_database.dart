import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:test_project/features/data/models/article.dart';

import 'DAO/article_dao.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [ArticleModel])
abstract class AppDatabase extends FloorDatabase {
  ArticleDao get articleDao;
}
