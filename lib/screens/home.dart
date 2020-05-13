import 'package:flutter/material.dart';
import 'package:music_recommender/services/spotify_api.dart';
import 'package:spotify/spotify.dart';

// Home screen of the app that should show the music recommendations
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // Spotify helper to get recommendations
  // TODO: Probably put this in the loading screen
  SpotifyHelper spotify = SpotifyHelper();

  @override
  Widget build(BuildContext context) {
    // Main widget
    return Scaffold(
      // Bg color
      backgroundColor: Theme.of(context).backgroundColor,
      // App bar
      appBar: AppBar(
        title: Text('Recommendations for you'),
        centerTitle: true,
      ),
      // Main Body
      // TODO: Create list of music recommendations
      body: Center(child: Text('Home Screen')),
      // Drawer for navigating between screens
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          // Elements in the drawer
          children: <Widget>[
            // Main drawer header at the top
            DrawerHeader(
              child: Center(
                child: Text(
                  'Welcome to Music Recommender!',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
              ),
            ),
            // Navigate to User Songs
            _getDrawerElement(
              'My Songs',
              'View all my favourite songs',
              () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/user_songs');
            }),
            // Navigate to Search Songs
            _getDrawerElement(
              'Search Songs',
              'Search songs and add to My Songs',
              () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/search');
            })
          ],
        ),
      ),
      // Temporary FAB
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () async {
          List<TrackSimple> _recommendedTracks = await spotify.getRecommendations();
          _recommendedTracks.forEach((element) {
            debugPrint(element.name);
          });
        },
      ),
    );
  }

  Widget _getDrawerElement(String title, String subtitle, Function onTapFunc) {
    // List Tile Widget
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20.0
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontStyle: FontStyle.italic
        ),
      ),
      onTap: onTapFunc,
    );
  }
}
