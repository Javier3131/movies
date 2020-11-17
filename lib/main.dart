import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/movie_detail_screen.dart';
import './providers/movies.dart';
import './screens/movies_screen.dart';
import './screens/movie_search_screen.dart';
import './screens/image_view.dart';
import 'utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final _greenColor = Utils().createMaterialColor(Color(0xFF6ac044));
  final _greenColor = const Color(0xFF6ac044);
  final _blackColor = Utils().createMaterialColor(Color(0xFF1d1d1d));
  final _textTheme = TextTheme(
    subtitle1: TextStyle(
      color: Colors.white,
    ),
    bodyText1: TextStyle(
      fontSize: 18.0,
      color: Colors.white,
    ),
    bodyText2: TextStyle(
      // color: const Color(0xFF8f888e),
      color: Colors.grey,
    ),
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Movies()),
      ],
      child: MaterialApp(
        title: 'Movies',
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        theme: ThemeData(
          primarySwatch: _blackColor,
          accentColor: _greenColor,
          canvasColor: _blackColor,
          buttonColor: _greenColor,
          appBarTheme: AppBarTheme(textTheme: _textTheme),
          primaryTextTheme: _textTheme,
          textTheme: _textTheme,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Arimo',
        ),
        darkTheme: ThemeData.dark(),
        initialRoute: '/',
        routes: {
          '/': (ctx) => MoviesScreen(),
          MovieDetailScreen.routeName: (ctx) => MovieDetailScreen(),
          MovieSearchScreen.routeName: (ctx) => MovieSearchScreen(),
          ImageView.routeName: (ctx) => ImageView(),
        },
      ),
    );
  }
}
