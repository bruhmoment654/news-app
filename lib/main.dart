import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/config/routes/routes.dart';
import 'package:test_project/config/theme/app_themes.dart';
import 'package:test_project/features/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:test_project/features/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:test_project/features/presentation/pages/home/daily_news.dart';
import 'package:test_project/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticlesBloc>(
      create: (context) => sl()..add(const GetArticles()),
      child: MaterialApp(
        theme: theme(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.onGenerateRoutes,
        home: const DailyNews(),
      ),
    );
  }
}
