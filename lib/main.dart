import 'package:complaints/providers/categories_provider.dart';
import 'package:complaints/providers/mails_provider.dart';
import 'package:complaints/providers/statuses_provider.dart';
import 'package:complaints/providers/tags_provider.dart';
import 'package:complaints/views/auth.dart';
import 'package:complaints/views/home.dart';
import 'package:complaints/views/loading.dart';
import 'package:complaints/views/main_layout.dart';
import 'package:complaints/views/message_detailes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<MailsProvider>(create: (_) => MailsProvider()),
    ChangeNotifierProvider<TagsProvider>(create: (_) => TagsProvider()),
    ChangeNotifierProvider<StatusesProvider>(create: (_) => StatusesProvider()),
    ChangeNotifierProvider<CategoriesProvider>(
        create: (_) => CategoriesProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xfff7f6ff),
          appBarTheme: const AppBarTheme(
              elevation: 0, backgroundColor: Color(0xfff7f6ff))),
      routes: {
        LoadingScreen.id: (context) => const LoadingScreen(),
        HomeScreen.id: (context) => const HomeScreen(),
        AuthScreen.id: (context) => const AuthScreen(),
        MainLayout.id: (context) => const MainLayout(),
        MessageDetailsScreen.id: (context) => const MessageDetailsScreen(),
      },
    );
  }
}
