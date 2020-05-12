import 'package:flutter/material.dart';

class UserSongsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('User Songs'),
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
