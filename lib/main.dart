import 'package:flutter/material.dart';
import 'package:music_recommender/screens/about.dart';
import 'package:music_recommender/screens/details.dart';
import 'package:music_recommender/screens/home.dart';
import 'package:music_recommender/screens/search.dart';
import 'package:music_recommender/screens/loading.dart';
import 'package:music_recommender/screens/user_songs.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Main App
    return MaterialApp(
      // Title of the app
      title: 'Music Recommender',
      // Theme of the app
      theme: ThemeData(
        // Default colors of the app
        primaryColor: Colors.grey[900],
        accentColor: Colors.blue,
        backgroundColor: Colors.black,
        // Colors for various widgets
        cardColor: Colors.grey[900],
        buttonColor: Colors.blue,
        // Default font family
        fontFamily: 'UbuntuMono',
      ),
      // Routes for the app
      routes: {
        '/': (context) => LoadingScreen(),
        '/home': (context) => HomeScreen(),
        '/user_songs': (context) => UserSongsScreen(),
        '/search': (context) => SearchScreen(),
        '/details': (context) => DetailsScreen(),
        '/about': (context) => AboutScreen()
      },
      // default route
      initialRoute: '/',
    );
  }
}
