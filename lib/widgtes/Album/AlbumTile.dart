import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:record_app/mixins/BaseMixins.dart';
import 'package:record_app/models/Album.dart';
import 'package:record_app/widgtes/common/BaseImage.dart';

class AlbumTile extends StatelessWidget with BaseMixins {
  final Album album;
  final bool isAsset;
  AlbumTile({
    this.album,
    this.isAsset = false,
  });
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              BaseImage(
                heroId: album.id,
                imageUrl: album.cover,
                height: height * 0.2,
                width: isAsset
                    ? width * 0.7
                    : responsive(context,
                        isTablet: 170.0, isPhone: 150.0, isSmallPhone: 135.0),
                radius: 5.0,
              ),
              Positioned(
                  right: 10,
                  bottom: 10,
                  child: Icon(
                    AntDesign.playcircleo,
                    color: Colors.white,
                  )),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: isAsset ? 15 : 5, bottom: 5),
            child: Text(
              album.title,
              style: TextStyle(
                  fontSize: isAsset ? 14 : 12, fontWeight: FontWeight.w600),
            ),
          ),
          if (!isAsset)
            Text(
              album.tracks != null
                  ? '${album.tracks.length} Tracks'
                  : '0 Tracks',
              style: TextStyle(
                fontSize: 10,
              ),
            ),
        ],
      ),
    );
  }
}
