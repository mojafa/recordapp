import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:record_app/config/AppColors.dart';
import 'package:record_app/widgtes/track/my_carousel.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                SizedBox(
                  height: 15,
                ),
                TopCarousel(
                  isAbout: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [
                          primary,
                          Colors.green,
                        ]),
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            AssetImage('assets/images/title1.jpeg'),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        contactTile(),
                        contactTile(
                            icon: FontAwesomeIcons.instagram,
                            color: Colors.red,
                            socialMedia: 'Instagram',
                            link: 'https://www.instagram.com/hassanakhaire',
                            handle: 'hassanakhaire'),
                        contactTile(
                          icon: FontAwesomeIcons.twitter,
                          color: Colors.blue,
                          handle: 'HassanAKhaire',
                          link: 'https://twitter.com/HassanAKhaire',
                          socialMedia: 'Twitter',
                        ),
                      ],
                    ))
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    '''Officia nisi nostrud reprehenderit velit tempor velit occaecat. Reprehenderit nisi dolore esse exercitation incididunt. Minim qui ea est quis Lorem sint consectetur esse in.
Irure ullamco dolore esse ad nisi cillum quis in ut eiusmod ipsum. Esse dolore ullamco id aliquip id eiusmod ipsum. Esse minim sit sint laborum nulla do ut fugiat. Amet incididunt occaecat velit occaecat dolor non adipisicing ex. Eiusmod nostrud fugiat laboris veniam tempor anim cillum ex officia dolor mollit magna officia. Eu velit nulla ad deserunt dolore commodo ipsum tempor qui dolor aliquip est deserunt nisi.Nisi do elit velit deserunt. Voluptate incididunt minim sunt ipsum aliqua minim elit consequat dolore irure fugiat excepteur veniam dolor. Sint qui tempor non laboris sunt in labore adipisicing dolor ad cupidatat exercitation in irure. Ipsum laborum ex officia reprehenderit esse Lorem quis sit esse dolor esse. Nulla adipisicing proident mollit eiusmod ex. Exercitation amet tempor culpa excepteur consequat eiusmod ipsum.''',
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Center(
                    child: Text(
                        'Mudane Hassan Ali Khaire | Musharrax Madaxwenye 2022-2026',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        )),
                  ),
                ))
          ],
        ));
  }

  Widget contactTile(
      {String socialMedia,
      String handle,
      String link,
      Color color,
      IconData icon}) {
    return SizedBox(
      height: 50,
      child: ListTile(
        onTap: () {
          if (link != null) {
            launch(link);
          } else {
            launch('https://www.facebook.com/HassanAliKhaire');
          }
        },
        dense: true,
        leading: Icon(
          icon ?? FontAwesome.facebook,
          color: color ?? Colors.blue[900],
        ),
        subtitle: Text(socialMedia ?? 'Facebook'),
        title: Text(handle ?? 'HassanAliKhaire'),
      ),
    );
  }
}
