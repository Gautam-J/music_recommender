import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';

// TODO: Put all Spotify under its own class (SpotifyHelper) under services package

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  // Spotify Credentials
  static var credentials = SpotifyApiCredentials(
    // client id
    '2b8e7fc5026f4421b3035f5820f801ff',
    // client secret
    '0630c8ba40924d96952ffeab53ee583c'
  );
  // Spotify object
  var spotify = SpotifyApi(credentials);

  @override
  Widget build(BuildContext context) {
    // Scaffold Widget
    return Scaffold(
      // App bar
      appBar: AppBar(
        title: Text('Search Songs'),
        centerTitle: true,
      ),
      // Main body
      body: Center(child: Text('Search Screen')),
      // Temporary FAB
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Temp Debug print statement
          debugPrint('Pressed FAB');
          // Get artists
          _getArtists([
            '0wv5i0ds2z040yx7oL6UZy',
            '7zFBW2JxM4bgTTKxCRcS8Q',
          ]);
          // Search on Spotify
          _getSearchResults('Rap god');
        },

      ),
    );
  }

  _getArtists(List<String> artistsList) async {
    // Iterable object artists
    var artists = await spotify.artists.list(artistsList);
    // Extract values from each artist
    artists.forEach((element) => debugPrint(element.name));
  }

  _getSearchResults(String searchText) async {
    // Search result
    var results = await spotify.search
      .get(searchText)
      .first(10)
      .catchError((err) => debugPrint((err as SpotifyException).message));
    // If empty result
    if (results == null) {
      return;
    }
    // Iterate through each page
    results.forEach((pages) {
      // Iterate through each item
      pages.items.forEach((item) {
        // search result item is a track
        if (item is TrackSimple) {
          // Name of the track
          debugPrint('Track Name: ${item.name}');
          // Iterate through all artists
          item.artists.forEach((artist) {
            debugPrint('Artist: ${artist.name}');
          });
          // Explicit or not
          debugPrint('Explicit: ${item.explicit}');
          // Duration of the track
          debugPrint('Duration (secs): ${item.durationMs / 1000}');
          // Spotify id
          debugPrint('Spotify ID: ${item.id}');
          // Spotify URI
          debugPrint('Spotify URI: ${item.uri}');
        }
      });
    });
  }

}
