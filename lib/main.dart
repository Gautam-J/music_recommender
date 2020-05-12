import 'package:flutter/material.dart';

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
        backgroundColor: Colors.grey[800],
        // Colors for various widgets
        cardColor: Colors.grey[300],
        buttonColor: Colors.blue,
        // Default font family
        fontFamily: 'UbuntuMono',
      ),
      // Home Route
      home: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('Hello World'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text(
                'Item 1',
                style: TextStyle(
                  fontStyle: FontStyle.italic
                ),
              ),
              leading: Icon(Icons.music_note),
              trailing: RaisedButton(
                onPressed: () {},
                child: Text('Play'),
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                'Item 2',
                style: TextStyle(
                  fontStyle: FontStyle.italic
                ),
              ),
              leading: Icon(Icons.music_note),
              trailing: RaisedButton(
                onPressed: () {},
                child: Text('Play'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
