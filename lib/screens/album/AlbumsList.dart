import 'package:flutter/material.dart';
import 'package:record_app/config/AppRoutes.dart';
import 'package:record_app/mixins/BaseMixins.dart';
import 'package:record_app/models/Album.dart';
import 'package:record_app/widgtes/Album/AlbumFavouriteButton.dart';
import 'package:record_app/widgtes/Album/AlbumTileActions.dart';
import 'package:record_app/widgtes/Common/BaseImage.dart';
import 'package:record_app/widgtes/Search/BaseMessageScreen.dart';
import 'package:record_app/models/empty_screen.dart';

class AlbumsList extends StatelessWidget with BaseMixins {
  final List<Album> albums;
  const AlbumsList({
    Key key,
    @required this.albums,
  }) : super(key: key);

  _buildTile(BuildContext context, Album album) => Column(children: <Widget>[
        ListTile(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.albumDetail,
              arguments: album,
            );
          },
          title: Text(
            album.title,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          subtitle: Text(
            ' ${album.tracks.length}  ${$t(context, 'Tracks')} ',
            style:
                TextStyle(color: Theme.of(context).colorScheme.primaryVariant),
          ),
          leading: BaseImage(
            heroId: album.id,
            imageUrl: album.cover,
            height: 40,
            width: 40,
            radius: 5.0,
          ),
          trailing: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              AlbumFavouriteButton(
                album: album,
              ),
              AlbumTileActions(
                album: album,
                // route: () {
                //   Navigator.of(context).pushNamed(
                //     AppRoutes.albumDetail,
                //     arguments: album,
                //   );
                // },
                title: 'View tracks',
                child: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).primaryColor,
                ),
              )
              // IconButton(
              //     icon: Icon(
              //       Icons.more_vert,
              //       color: Theme.of(context).primaryColor,
              //     ),
              //     onPressed: () => {}),
            ],
          ),
        ),
        Divider(
          color: Theme.of(context).cardColor,
        ),
      ]);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            child: albums.length > 0
                ? ListView.builder(
                    itemCount: albums.length,
                    itemBuilder: (context, index) {
                      return _buildTile(context, albums[index]);
                    },
                  )
                : emptyScreen(
                    context,
                    3,
                    'Nothing to',
                    15.0,
                    'Show Here',
                    50,
                    'Go and Add Something',
                    23.0,
                  ),
          ),
        ),
      ],
    );
  }
}
