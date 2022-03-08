import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:record_app/config/AppRoutes.dart';
import 'package:record_app/mixins/BaseMixins.dart';
import 'package:record_app/models/Album.dart';
import 'package:record_app/models/Track.dart';
import 'package:record_app/screens/album/list_album.dart';
import 'package:record_app/widgtes/Album/AlbumTile.dart';
import 'package:record_app/widgtes/Common/BaseScaffold.dart';
import 'package:record_app/widgtes/track/my_carousel.dart';

class AlbumsScreen extends StatelessWidget with BaseMixins {
  final ScrollController scrollController = new ScrollController();

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
        audio1,
        'https://firebasestorage.googleapis.com/v0/b/audio-project-b56de.appspot.com/o/intro_1.png?alt=media&token=8447a884-b2b5-40f2-9e12-c18ce938750a',
        [
          Track(
              1,
              'Fariinta Musharraxa',
              audio1,
              'https://firebasestorage.googleapis.com/v0/b/audio-project-b56de.appspot.com/o/Intro_1.mp3?alt=media&token=2204a9ad-ebf8-4b38-acc3-aeb21842cfa4',
              'https://firebasestorage.googleapis.com/v0/b/audio-project-b56de.appspot.com/o/intro_1.png?alt=media&token=8447a884-b2b5-40f2-9e12-c18ce938750a',
              null,
              '2022-03-06T08:09:24.775929')
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
              'https://firebasestorage.googleapis.com/v0/b/audio-project-b56de.appspot.com/o/Intro_2.mp3?alt=media&token=801935ac-6f81-46df-ab78-375db3781250',
              'https://firebasestorage.googleapis.com/v0/b/audio-project-b56de.appspot.com/o/intro_2.png?alt=media&token=d1f82f09-8e16-4547-ac4c-a2fa2dba9a36',
              null,
              '2022-03-06T08:09:24.775929')
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
              '2022-03-06T08:09:24.775929')
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
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: ListView(
                  children: [
                    Row(children: [
                      SizedBox(
                          height: 40,
                          child: Image.asset('assets/images/logo.png')),
                      Spacer(),
                      Column(
                        children: [
                          Icon(
                            Icons.play_arrow_outlined,
                            size: 30,
                            color: Theme.of(context).primaryColor,
                          ),
                          Text('Play All',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).iconTheme.color,
                              ))
                        ],
                      ),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: Icon(
                      //     Icons.share,
                      //     size: 24,
                      //   ),
                      // ),
                      SizedBox(width: 15),
                    ]),
                    SizedBox(height: 15),
                    TopCarousel(),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          'HASSAN ALI KHAIRE',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
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
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
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
                              width: 150,
                              child: AlbumTile(
                                album: staticAlbums[0],
                                // isAsset: true,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                AppRoutes.albumDetail,
                                arguments: staticAlbums[1],
                              );
                            },
                            child: SizedBox(
                              width: 150,
                              child: AlbumTile(
                                album: staticAlbums[1],
                                // isAsset: true,
                              ),
                            ),
                          ),
                          // Column(
                          //   children: [
                          //     Container(
                          //       height: size.height * .2,
                          //       margin: EdgeInsets.symmetric(horizontal: 10),
                          //       width: 150,
                          //       child: Image.asset(
                          //         'assets/images/title1.jpeg',
                          //         fit: BoxFit.cover,
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       height: 10,
                          //     ),
                          //     Text(
                          //       'Farriinta Musharraxa',
                          //       style: TextStyle(fontWeight: FontWeight.w500),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(
                          //   width: 10,
                          // ),
                          // Column(
                          //   children: [
                          //     Container(
                          //       height: size.height * .2,
                          //       margin: EdgeInsets.symmetric(horizontal: 10),
                          //       width: 150,
                          //       child: Image.asset(
                          //         'assets/images/title2.jpeg',
                          //         fit: BoxFit.cover,
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       height: 10,
                          //     ),
                          //     Text(
                          //       'Hordhac',
                          //       style: TextStyle(fontWeight: FontWeight.w500),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    // StreamBuilder(
                    //   stream: FirebaseFirestore.instance
                    //       .collection('albums')
                    //       .limit(2)
                    //       .snapshots(),
                    //   builder: (ctx, snapshot) {
                    //     if (!snapshot.hasData) {
                    //       return Flushbar(
                    //         backgroundColor: Theme.of(context)
                    //             .colorScheme
                    //             .surface
                    //             .withOpacity(0.8),
                    //         icon: Icon(
                    //           Icons.error_outline,
                    //           color: Theme.of(context).primaryColor,
                    //         ),
                    //         duration: Duration(seconds: 3),
                    //         flushbarPosition: FlushbarPosition.TOP,
                    //         titleText: Text($t(context, 'ops')),
                    //         messageText: Text('Error while registering'),
                    //       );
                    //     }

                    //     if (snapshot.hasError) {
                    //       return Flushbar(
                    //         backgroundColor: Theme.of(context)
                    //             .colorScheme
                    //             .surface
                    //             .withOpacity(0.8),
                    //         icon: Icon(
                    //           Icons.error_outline,
                    //           color: Theme.of(context).primaryColor,
                    //         ),
                    //         duration: Duration(seconds: 3),
                    //         flushbarPosition: FlushbarPosition.TOP,
                    //         titleText: Text($t(context, 'ops')),
                    //         messageText: Text('Error while registering'),
                    //       );
                    //     }
                    //     List<DocumentSnapshot> docs = snapshot.data.docs;
                    //     return Container(
                    //       width: size.width,
                    //       child: SingleChildScrollView(
                    //         scrollDirection: Axis.horizontal,
                    //         child: Row(
                    //             children: List.generate(
                    //                 docs.length,
                    //                 (index) => AlbumTile(
                    //                     album: Album.fromJson(docs[index].data())))),
                    //       ),
                    //     );
                    //   },
                    // ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Text('CHAPTERS',
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).iconTheme.color,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.green,
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
                                      isSmallPhone: 2, isPhone: 2, isTablet: 4),
                                  childAspectRatio: responsive(context,
                                      isPhone: 0.8,
                                      isSmallPhone: 0.8,
                                      isTablet: 0.6)),
                          itemBuilder: (context, index) {
                            return _buildGridItem(
                                context, Album.fromJson(docs[index].data()));
                          },
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Text('CONCLUSION',
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).iconTheme.color,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    SizedBox(height: 10),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                AppRoutes.albumDetail,
                                arguments: staticAlbums[2],
                              );
                            },
                            child: SizedBox(
                              width: 150,
                              child: AlbumTile(
                                album: staticAlbums[2],
                                // isAsset: true,
                              ),
                            ),
                          ),
                        ])),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: size.width,
                    color: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 3),
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
