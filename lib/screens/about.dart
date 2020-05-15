import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bg of the scaffold
      backgroundColor: Theme.of(context).backgroundColor,
      // Appbar
      appBar: AppBar(
        title: Text('About'),
        centerTitle: true,
      ),
      // main body
      body: Padding(
        // padding
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
        // main column
        child: Column(
          // start from left to right
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              // profile image
              child: CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('images/profile.jpg'),
              )
            ),
            // divider
            Divider(
              color: Colors.grey[800],
              height: 60.0,
            ),
            // Heading for name
            Text(
              'NAME',
              style: TextStyle(
                letterSpacing: 2.0,
                color: Colors.grey[500],
              ),
            ),
            SizedBox(height: 10.0),
            // my name
            Text(
              'Gautam J',
              style: TextStyle(
                color: Colors.grey[200],
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 30.0),
            // Heading for email
            Text(
              'EMAIL',
              style: TextStyle(
                letterSpacing: 2.0,
                color: Colors.grey[500],
              ),
            ),
            SizedBox(height: 10.0),
            // email
            Text(
              'gautam.jayapal@gmail.com',
              style: TextStyle(
                color: Colors.grey[200],
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(height: 30.0),
            // Heading for social icons
            Text(
              'SOCIAL',
              style: TextStyle(
                letterSpacing: 2.0,
                color: Colors.grey[500],
              ),
            ),
            SizedBox(height: 10.0),
            // social icons
            Center(
              child: Wrap(
                alignment: WrapAlignment.spaceEvenly,
                spacing: 25.0,
                children: <Widget>[
                  // facebook
                  IconButton(
                    color: Colors.grey[500],
                    icon: FaIcon(FontAwesomeIcons.facebook),
                    onPressed: () {
                      setState(() {
                        _launchURL('https://www.facebook.com/Gautam.Jayapal/');
                      });
                    },
                  ),
                  // instagram
                  IconButton(
                    color: Colors.grey[500],
                    icon: FaIcon(FontAwesomeIcons.instagram),
                    onPressed: () {
                      setState(() {
                        _launchURL('https://www.instagram.com/gautam.j/');
                      });
                    },
                  ),
                  // twitter
                  IconButton(
                    color: Colors.grey[500],
                    icon: FaIcon(FontAwesomeIcons.twitter),
                    onPressed: () {
                      setState(() {
                        _launchURL('https://twitter.com/GautamJayapal');
                      });
                    }
                  ),
                  // github
                  IconButton(
                    color: Colors.grey[500],
                    icon: FaIcon(FontAwesomeIcons.github),
                    onPressed: () {
                      setState(() {
                        _launchURL('https://github.com/Gautam-J');
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function that launches an URL
  _launchURL(String _url) async {
    if (await canLaunch(_url)) {
      await launch(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }

}
