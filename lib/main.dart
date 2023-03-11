import 'package:complaints/providers/categories_provider.dart';
import 'package:complaints/providers/mails_provider.dart';
import 'package:complaints/providers/statuses_provider.dart';
import 'package:complaints/providers/tags_provider.dart';
import 'package:complaints/views/all_mails_of_tag.dart';
import 'package:complaints/views/auth.dart';
import 'package:complaints/views/filter.dart';
import 'package:complaints/views/home.dart';
import 'package:complaints/views/loading.dart';
import 'package:complaints/views/main_layout.dart';
import 'package:complaints/views/message_detailes.dart';
import 'package:complaints/views/search.dart';
import 'package:complaints/views/tags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<TagsProvider>(create: (context) => TagsProvider()),
    ChangeNotifierProvider<MailsProvider>(create: (context) => MailsProvider()),
    ChangeNotifierProvider<StatusesProvider>(
        create: (context) => StatusesProvider()),
    ChangeNotifierProvider<CategoriesProvider>(
        create: (context) => CategoriesProvider()),
  ], child: const MyApp()));
  FlutterNativeSplash.remove();
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
        AllMailsOfTagScreen.id: (context) => const AllMailsOfTagScreen(),
        TagsScreen.id: (context) => const TagsScreen(),
        SearchScreen.id: (context) => const SearchScreen(),
        FilterScreen.id: (context) => const FilterScreen(),
      },
    );
  }
}
