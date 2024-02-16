import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/features/domain/entities/article.dart';
import 'package:test_project/features/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:test_project/features/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:test_project/features/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:test_project/features/presentation/widgets/article_tile.dart';

import '../../../../injection_container.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(
        'News',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        GestureDetector(
          onTap: () => _onShowSavedArticlesViewTapped(context),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Icon(Icons.bookmark, color: Colors.black),
          ),
        ),
      ],
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteArticlesBloc, RemoteArticleState>(
      builder: (_, state) {
        if (state is RemoteArticlesLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is RemoteArticlesError) {
          return const Center(
            child: Icon(Icons.refresh),
          );
        }
        if (state is RemoteArticlesDone) {
          state.articles?.forEach((element) {});
          return ListView.builder(
              itemCount: state.articles!.length,
              itemBuilder: (context, index) => ArticleWidget(
                    article: state.articles![index],
                    onArticlePressed: (article) =>
                        _onArticlePressed(context, article),
                  ));
        }
        return const SizedBox();
      },
    );
  }

  _onArticlePressed(BuildContext context, ArticleEntity articleEntity) {
    Navigator.pushNamed(context, '/ArticleDetails', arguments: articleEntity);
  }

  _onShowSavedArticlesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/SavedArticles');
  }
}
