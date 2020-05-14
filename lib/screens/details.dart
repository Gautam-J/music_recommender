import 'package:flutter/material.dart';
import 'package:music_recommender/services/spotify_api.dart';
import 'package:music_recommender/utils/database_helper.dart';
import 'package:music_recommender/models/my_track.dart';

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  // initialize data as empty object
  Map<String, dynamic> data = Map<String, String>();
  // initialize a spotify helper
  SpotifyHelper spotify = SpotifyHelper();
  // initialize a database helper
  DatabaseHelper helper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    // Get data from loading screen
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    // Scaffold Widget
    return Scaffold(
      // Appbar
      appBar: AppBar(
        title: Text('Details'),
      ),
      // Main Body
      body: FutureBuilder(
        // get future data
        future: spotify.getTrackData(data['track_sId']),
        // building widget
        builder: (context, snapshot) {
          // If async await is completed
          if (snapshot.connectionState == ConnectionState.done) {
            // TODO: Customize to show all details of the Track object
            return Container(
              // color of the background container
              color: Colors.white,
              // Main Body
              child: Column(
                children: <Widget>[
                  // Track name
                  Text('Track Name: ${snapshot.data.name}'),
                  // Artists
                  Expanded(
                    child: ListView.builder(
                      // number of artists in track
                      itemCount: snapshot.data.artists.length,
                      // Build widgets
                      itemBuilder: (context, index) {
                        // Artist name
                        // TODO: add popularity and image
                        return Text('Artist: ${snapshot.data.artists[index].name}');
                      },
                    ),
                  ),
                  // Album name
                  // TODO: add image
                  Text('Album Name: ${snapshot.data.album.name}'),
                  // Duration
                  Text('Duration (secs): ${snapshot.data.durationMs / 1000}'),
                  // Explicit
                  Text('Explicit: ${snapshot.data.explicit}'),
                  // Popularity
                  Text('Popularity: ${snapshot.data.popularity}'),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            // If code has error, throw it
            throw snapshot.error;
          } else {
            // Progress circle while async await is happening
            return Center(
              child: CircularProgressIndicator()
            );
          }
        },
      ),
      // FAB to save
      floatingActionButton: FloatingActionButton(
        // Plus icon
        child: Icon(Icons.add),
        // bg color of the icon
        backgroundColor: Theme.of(context).accentColor,
        // tool tip when long pressed
        tooltip: 'Add to My Songs',
        // Save on press
        onPressed: () {
          debugPrint('On user list: ${data['onUserList']}');
          if (data['onUserList'] == null) {
            _save(context, data['track_Name'], data['track_sId']);
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  // Save track to database
  _save(BuildContext context, String _name, String _sId) async {
    MyTrack _myTrack = MyTrack(_name, _sId);
    await helper.insertTrack(_myTrack);
  }

}
