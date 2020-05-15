import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:music_recommender/services/spotify_api.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Loading screen to get recommendations
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  // Spotify helper to get recommendations
  SpotifyHelper spotify = SpotifyHelper();

  // Function that gets recommendations and pushes to home page
  void _getRecommendationsList() async {
    // get recommendations
    var _recommendedTracks = await spotify.getRecommendations();
    // Wait for 2 seconds further
    await Future.delayed(Duration(seconds: 1));
    // Push to recommendations to home page
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'recommendations': _recommendedTracks,
    });
  }

  @override
  void initState() {
    super.initState();
    _getRecommendationsList();
  }

  @override
  Widget build(BuildContext context) {
    // Main Scaffold Widget
    return Scaffold(
      // bg color of the scaffold
      backgroundColor: Theme.of(context).backgroundColor,
      // main body
      body: Center(
        // Animation while getting recommendations
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Animation
            SpinKitRipple(
              // Color of the animation
              color: Theme.of(context).accentColor,
              // Size of the animation
              size: 100.0,
            ),
            SizedBox(height: 30.0),
            // Text to display while loading
            Text(
              'Getting personalized recommendations',
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontSize: 18.0,
              )
            ),
          ],
        ),
      ),
    );
  }
}
