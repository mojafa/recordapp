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
          title: Image.asset(
            'assets/images/logo.png',
            height: 45,
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
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
                      width: 15,
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
                        radius: 70,
                        backgroundImage:
                            AssetImage('assets/images/title1.jpeg'),
                      ),
                    ),
                    SizedBox(
                      width: 15,
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
                    child: RichText(
                      text: TextSpan(
                          text: 'April 15 1968:',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyText1.color,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  ''' Ayuu Xasan Cali Khayre ku dhashay degmada Ceelbuur ee gobolka Galguduud.Dugsiga hoose dhexe wuxuu Xasan Cali Kheyre kaga baxay degmada Ceelbuur. Wuxuuna dugsiga sare kaga baxay iskuulka sare ee Cismaan Geeddi Raage ee magaalada Muqdisho.Ciidanka Booliska Qaranka Xasan Cali Khayre waxa uu markii uu ka baxay dugsiga sare gutay waajibkiisa shaqada qaran waxa uuna ka mid noqday Ciidanka Booliska Qaranka wuxuuna kasoo shaqeeyay Saldhigyada Degmooyinka Marka iyo Hodon.''',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                color:
                                    Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ),
                            TextSpan(
                              text: '\n\n1989: ',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '''ayuu Xasan Cali Kheyre magangalyo qoxootinimo ka helay dalka Norway. Wuxuuna mar kale dib u qaatay waxbarashada dugsiga sarre. ''',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                color:
                                    Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ),
                            TextSpan(
                              text: '\n\n1998: ',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '''ayuu ka qalanjabiyay jaamacada Oslo ee University of Oslo, wuxuuna bartay cilmiga siyaasada iyo dhaqaalaha.''',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 13,
                                color:
                                    Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ),
                            TextSpan(
                              text: '\n\n2001: ',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ),
                            TextSpan(
                              text:
                                  '''wuxuu Xasan Cali Kheyre shahaaddada labaad ee MBA-da ka qaatay jaamacada Heriot-Watt University, Edinburgh Campus ee magaalada Edinburgh ee dalka Scotland. Wuxuuna bartay cilmiga dhaqaalaha iyo ganacsiga, isaga oo si gaar ah ugu taqusasay maadooyinka maalgalinta(Investment)''',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                color:
                                    Theme.of(context).textTheme.bodyText1.color,
                              ),
                            ),
                          ]),
                    )),
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
                  color: primary,
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
