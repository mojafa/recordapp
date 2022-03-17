import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:record_app/config/AppColors.dart';
import 'package:record_app/config/AppRoutes.dart';
import 'package:record_app/mixins/BaseMixins.dart';
import 'package:record_app/models/Album.dart';
import 'package:record_app/models/Track.dart';
import 'package:record_app/screens/DownloadScreen.dart';
import 'package:record_app/screens/album/list_album.dart';
import 'package:record_app/screens/contact/about_page.dart';
import 'package:record_app/widgtes/Album/AlbumTile.dart';
import 'package:record_app/widgtes/Common/BaseScaffold.dart';
import 'package:record_app/widgtes/track/my_carousel.dart';

class AlbumsScreen extends StatelessWidget with BaseMixins {
  final ScrollController scrollController = ScrollController();

  _buildGridItem(BuildContext context, Album album) => InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRoutes.albumDetail,
            arguments: album,
          );
        },
        child: AlbumTile(album: album),
      );
  List<Album> staticAlbums = [
    Album(
        1,
        'Fariinta Musharraxa',
        '',
        'https://firebasestorage.googleapis.com/v0/b/audio-project-b56de.appspot.com/o/intro_1.png?alt=media&token=8447a884-b2b5-40f2-9e12-c18ce938750a',
        [
          Track(
              1,
              'Fariinta Musharraxa',
              audio1,
              'https://firebasestorage.googleapis.com/v0/b/audio-project-b56de.appspot.com/o/Intro_1.mp3?alt=media&token=2204a9ad-ebf8-4b38-acc3-aeb21842cfa4',
              'https://firebasestorage.googleapis.com/v0/b/audio-project-b56de.appspot.com/o/intro_1.png?alt=media&token=8447a884-b2b5-40f2-9e12-c18ce938750a',
              null,
              '239')
        ]),
    Album(
        2,
        'Hordhac',
        '',
        'https://firebasestorage.googleapis.com/v0/b/audio-project-b56de.appspot.com/o/intro_2.png?alt=media&token=d1f82f09-8e16-4547-ac4c-a2fa2dba9a36',
        [
          Track(
              2,
              'Hordhac',
              audio2,
              'https://firebasestorage.googleapis.com/v0/b/audio-project-b56de.appspot.com/o/Intro_2.mp3?alt=media&token=0c8324de-7e60-4844-b38c-97746769ecb5',
              'https://firebasestorage.googleapis.com/v0/b/audio-project-b56de.appspot.com/o/intro_2.png?alt=media&token=d1f82f09-8e16-4547-ac4c-a2fa2dba9a36',
              null,
              '108')
        ]),
    Album(
        3,
        'Gunaanad',
        '',
        'https://firebasestorage.googleapis.com/v0/b/audio-project-b56de.appspot.com/o/conclusion.png?alt=media&token=4fb07ef1-0399-4fda-b454-469f56690acb',
        [
          Track(
              2,
              'Gunaanad',
              audio3,
              'https://firebasestorage.googleapis.com/v0/b/audio-project-b56de.appspot.com/o/Conclusion.mp3?alt=media&token=f9dbe465-94f0-4fd6-a3a1-49f460b2ba56',
              'https://firebasestorage.googleapis.com/v0/b/audio-project-b56de.appspot.com/o/conclusion.png?alt=media&token=4fb07ef1-0399-4fda-b454-469f56690acb',
              null,
              '78')
        ]),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BaseScaffold(
        isLoaded: true,
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Column(
                  children: [
                    Row(children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => AboutScreen());
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              AssetImage('assets/images/profile.jpeg'),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          scrollController.animateTo(0,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        child: SizedBox(
                          height: 45,
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Get.to(() => DownloadScreen());
                        },
                        child: SizedBox(
                          width: 40,
                          child: Lottie.asset(
                            'assets/down.json',
                            repeat: false,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                    ]),
                    SizedBox(height: 10),
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        children: [
                          TopCarousel(),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Text(
                                'HASSAN ALI KHAIRE',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Container(
                                height: 20,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                width: 3,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              Text(
                                'SOOMALIYA',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: secondary),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      AppRoutes.albumDetail,
                                      arguments: staticAlbums[0],
                                    );
                                  },
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: AlbumTile(
                                      album: staticAlbums[0],
                                      isAsset: true,
                                      // isAsset: true,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      AppRoutes.albumDetail,
                                      arguments: staticAlbums[1],
                                    );
                                  },
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: AlbumTile(
                                      album: staticAlbums[1],
                                      isAsset: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: Text('Hiigsiyada',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context).iconTheme.color,
                                  fontWeight: FontWeight.w300,
                                )),
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: secondary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          ),
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('albums')
                                .snapshots(),
                            builder: (ctx, snapshot) {
                              if (!snapshot.hasData) {
                                return Flushbar(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .surface
                                      .withOpacity(0.8),
                                  icon: Icon(
                                    Icons.error_outline,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  duration: Duration(seconds: 3),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  titleText: Text($t(context, 'ops')),
                                  messageText: Text('Error while registering'),
                                );
                              }

                              if (snapshot.hasError) {
                                return Flushbar(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .surface
                                      .withOpacity(0.8),
                                  icon: Icon(
                                    Icons.error_outline,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  duration: Duration(seconds: 3),
                                  flushbarPosition: FlushbarPosition.TOP,
                                  titleText: Text($t(context, 'ops')),
                                  messageText: Text('Error while registering'),
                                );
                              }
                              List<DocumentSnapshot> docs = snapshot.data.docs;
                              return GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                controller: scrollController,
                                itemCount: docs.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: responsive(context,
                                            isSmallPhone: 2,
                                            isPhone: 2,
                                            isTablet: 4),
                                        childAspectRatio: responsive(context,
                                            isPhone: 0.8,
                                            isSmallPhone: 0.8,
                                            isTablet: 0.6)),
                                itemBuilder: (context, index) {
                                  return _buildGridItem(context,
                                      Album.fromJson(docs[index].data()));
                                },
                              );
                            },
                          ),
                          SizedBox(height: 10),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: Text('Gunaanad',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Theme.of(context).iconTheme.color,
                                  fontWeight: FontWeight.w300,
                                )),
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: secondary,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Row(children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      AppRoutes.albumDetail,
                                      arguments: staticAlbums[2],
                                    );
                                  },
                                  child: SizedBox(
                                    width: size.width * 0.9,
                                    child: AlbumTile(
                                      album: staticAlbums[2],
                                      isAsset: true,
                                    ),
                                  ),
                                ),
                              ])),
                          SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: size.width,
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
          ),
        ),
      ),
    );
  }
}
