import 'package:flutter/material.dart';
import 'package:music_recommender/services/spotify_api.dart';
import 'package:spotify/spotify.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  // Create an instance of spotify helper
  static SpotifyHelper spotify = SpotifyHelper();

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
      body: FutureBuilder(
        // Get search results
        // TODO: Implement a search bar and have this dynamic
        future: spotify.getSearchResults('rap god'),
        // builder with list
        builder: (context, snapshot) {
          // If async await process is completed
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              child: ListView.builder(
                // Number of elements
                itemCount: snapshot.data.length,
                // Widget for each element
                itemBuilder: (context, index) {
                  // Create empty list for artists
                  List<String> artistsList = [];
                  // Iterate through artists per track
                  snapshot.data[index].artists.forEach((_artist) {
                    // Add artist name to artistsList
                    artistsList.add(_artist.name);
                  });
                  // Card widget
                  return Card(
                    // List tile widget
                    child: ListTile(
                      // Name of the track
                      title: Text(snapshot.data[index].name),
                      // Artists
                      subtitle: Text(artistsList.toString().replaceAll('[', '').replaceAll(']', '')),
                      // Music Icon
                      leading: Icon(Icons.music_note),
                      // Favourite Icon
                      // TODO: Change icon if track already in user's database
                      trailing: Icon(
                        Icons.favorite_border,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            // If code has error, throw it
            throw snapshot.error;
          } else {
            // Progress circle while async await is happening
            return Center(
              child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
