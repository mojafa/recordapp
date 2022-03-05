import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:record_app/config/AppRoutes.dart';
import 'package:record_app/mixins/BaseMixins.dart';
import 'package:record_app/models/Album.dart';
import 'package:record_app/providers/AlbumProvider.dart';
import 'package:record_app/widgtes/Album/AlbumTile.dart';
import 'package:record_app/widgtes/Common/BaseConnectivity.dart';
import 'package:record_app/widgtes/Common/BasePagination.dart';
import 'package:record_app/widgtes/Common/BaseScaffold.dart';
import 'package:provider/provider.dart';
import 'package:record_app/widgtes/track/top_ads.dart';

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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Spacer(),
                SizedBox(
                    height: 40, child: Image.asset('assets/images/logo.png')),
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
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Container(
                    height: 22,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 3,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  Text(
                    'SOOMALIYA',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ],
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
              // Container(
              //   margin: EdgeInsets.symmetric(vertical: 10),
              //   child: Text('CHAPTERS',
              //       style: TextStyle(
              //         fontSize: 22,
              //         color: Theme.of(context).iconTheme.color,
              //         fontWeight: FontWeight.bold,
              //       )),
              // ),
              Expanded(
                child: StreamBuilder(
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
                      physics: BouncingScrollPhysics(),
                      controller: scrollController,
                      itemCount: docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: responsive(context,
                              isSmallPhone: 2, isPhone: 2, isTablet: 4),
                          childAspectRatio: responsive(context,
                              isPhone: 0.8, isSmallPhone: 0.8, isTablet: 0.6)),
                      itemBuilder: (context, index) {
                        return _buildGridItem(
                            context, Album.fromJson(docs[index].data()));
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
