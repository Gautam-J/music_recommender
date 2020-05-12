import 'package:flutter/material.dart';

// Home screen of the app that should show the music recommendations
class HomeScreen extends StatelessWidget {
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
              debugPrint('Clicked My Songs');
              Navigator.pop(context);
              Navigator.pushNamed(context, '/user_songs');
            }),
            // Navigate to Search Songs
            _getDrawerElement(
              'Search Songs',
              'Search songs and add to My Songs',
              () {
              debugPrint('Clicked Search Songs');
              Navigator.pop(context);
              Navigator.pushNamed(context, '/search');
            })
          ],
        ),
      ),
    );
  }

  // Returns a List Tile that is shown in the drawer
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
