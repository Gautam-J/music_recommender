import 'package:flutter/material.dart';
import 'package:music_recommender/services/spotify_api.dart';
import 'package:music_recommender/utils/database_helper.dart';
import 'package:music_recommender/models/my_track.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  // Create an instance of spotify helper
  static SpotifyHelper spotify = SpotifyHelper();
  // Controller for getting search query
  TextEditingController searchController = TextEditingController();
  // initial empty user query
  static String userQuery;
  // Database helper to save and delete favourite songs
  DatabaseHelper helper = DatabaseHelper();

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // All widgets in this screen
        child: Column(
          children: <Widget>[
            // Search field
            TextField(
              // Decoration for the field
              decoration: InputDecoration(
                // padding for the text field
                contentPadding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
                // hint text to show the user
                hintText: 'Search for a song...',
                // styling hint text
                hintStyle: TextStyle(
                  fontSize: 18.0,
                  fontStyle: FontStyle.italic
                ),
                // Search button at the right
                suffix: FlatButton(
                  child: Text('Search'),
                  onPressed: () {
                    userQuery = searchController.text;
                    if (userQuery != null) {
                      Navigator.popAndPushNamed(context, '/search');
                    }
                  },
                ),
                // Search icon at the left
                prefixIcon: Icon(Icons.search)
              ),
              // Styling user query
              style: TextStyle(
                fontSize: 20.0,
              ),
              // controller to retrieve value
              controller: searchController,
              // function to call when query is submitted
              onSubmitted: (value) {
                userQuery = value;
                if (userQuery != null) {
                Navigator.popAndPushNamed(context, '/search');
                }
              },
            ),
            SizedBox(height: 10.0),
            // Builder of all search result data
            Expanded(
              child: FutureBuilder(
                // Get search results
                future: spotify.getSearchResults(userQuery),
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
                              onTap: () {
                                // try removing setState
                                _save(context, snapshot.data[index].name, snapshot.data[index].uri);
                              },
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
            ),
          ],
        ),
      ),
    );
  }

  // Save track to database
  _save(BuildContext context, String _name, String _uri) async {
    int result;
    MyTrack _myTrack = MyTrack(_name, _uri);
    result = await helper.insertTrack(_myTrack);

    if (result != 0) {
      // Success
      _showSnackBar(context, 'Added $_name to Favourite');
    } else {
      // failure
      _showSnackBar(context, 'Failed to add $_name');
    }
  }

  // show SnackBar
  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

}
