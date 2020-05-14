import 'package:flutter/material.dart';
import 'package:music_recommender/models/my_track.dart';
import 'package:spotify/spotify.dart';
import 'package:music_recommender/utils/database_helper.dart';

class SpotifyHelper {

  // Spotify Credentials
  static var _credentials = SpotifyApiCredentials(
    // client id
    '2b8e7fc5026f4421b3035f5820f801ff',
    // client secret
    '0630c8ba40924d96952ffeab53ee583c'
  );
  // Spotify object
  var _spotify = SpotifyApi(_credentials);
  // Database helper object
  DatabaseHelper databaseHelper = DatabaseHelper();

  // Function that returns a list of tracks from search results
  Future<List<TrackSimple>> getSearchResults(String searchText) async {
    // Empty list for all tracks retrieved from results
    List<TrackSimple> resultTracks = [];
    // check if user query is null
    if (searchText == null) {
      return resultTracks;
    }
    // Search result
    var _results = await _spotify.search
      .get(searchText)
      .first(10)
      .catchError((err) => debugPrint((err as SpotifyException).message));

    // Iterate through each page
    _results.forEach((_pages) {
      // Iterate through each item
      _pages.items.forEach((_item) {
        // search result item is a track
        if (_item is TrackSimple) {
          // Add it to resultTrack
          resultTracks.add(_item);
        }
      });
    });
    // return final list of all track items
    return resultTracks;
  }

  // Function that returns a list of recommendation tracks
  Future<List<TrackSimple>> getRecommendations() async {
    // List of user's favourite songs
    List<MyTrack> _userTracks = await databaseHelper.getTrackList();

    if (_userTracks.length == 0) {
      return null;
    }

    // List of track IDs
    List<String> _trackIds = List<String>();

    _userTracks.forEach((element) {
      _trackIds.add(element.sId);
    });

    // Get recommendations based on user's songs
    Recommendations _recommendations = await _spotify.recommendations.get(
      // max seeds: 5, get the last 5 as that will be more accurate
      seedTracks: _trackIds.length <= 5 ? _trackIds : _trackIds.sublist(_trackIds.length - 5),
      limit: 50,
    );

    return _recommendations.tracks;
  }

  // Function that returns a Track object given track ID
  Future<Track> getTrackData(String _trackSId) async {
    Track _track = await _spotify.tracks.get(_trackSId);
    return _track;
  }
}
