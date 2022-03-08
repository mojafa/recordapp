import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Us',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Column(children: [
        contactTile(),
        contactTile(
            icon: FontAwesomeIcons.instagram,
            color: Colors.red,
            socialMedia: 'Instagram',
            handle: '@hassan_khaire'),
        contactTile(
            icon: FontAwesomeIcons.googlePlus,
            color: Colors.red,
            socialMedia: 'Gmail',
            handle: 'khaire@gmail.com'),
        contactTile(
          icon: FontAwesomeIcons.twitter,
          color: Colors.blue,
          handle: '@khaire',
          socialMedia: 'Twitter',
        ),
        contactTile(
          icon: FontAwesomeIcons.youtube,
          color: Colors.red,
          handle: 'HassanKhaire',
          socialMedia: 'Youtube',
        ),
      ]),
    );
  }

  Widget contactTile(
      {String socialMedia,
      String handle,
      String link,
      Color color,
      IconData icon}) {
    return ListTile(
      leading: Icon(
        icon ?? FontAwesome.facebook,
        color: color ?? Colors.blue[900],
      ),
      title: Text(socialMedia ?? 'Facebook'),
      subtitle: Text(handle ?? 'HassanAliKhaire'),
    );
  }
}
