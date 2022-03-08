import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:record_app/config/AppRoutes.dart';
import 'package:record_app/mixins/BaseMixins.dart';
import 'package:record_app/models/Album.dart';
import 'package:record_app/models/Track.dart';
import 'package:record_app/providers/DownloadProvider.dart';
import 'package:record_app/providers/PlayerProvider.dart';
import 'package:record_app/widgtes/Common/BaseImage.dart';
import 'package:record_app/widgtes/track/TrackFavouriteButton.dart';
import 'package:record_app/widgtes/track/TrackTileActions.dart';
import 'package:provider/provider.dart';

import 'TrackPlayButton.dart';

class TrackTile extends StatefulWidget {
  final bool isDownloadTile;
  final Album album;
  final Track track;

  final int index;
  final List<Track> tracks;
  TrackTile(
      {this.track, this.index, this.isDownloadTile, this.album, this.tracks});

  @override
  _TrackTileState createState() => _TrackTileState();
}

class _TrackTileState extends State<TrackTile> with BaseMixins {
  @override
  Widget build(BuildContext context) {
    PlayerProvider p = Provider.of<PlayerProvider>(context);
    final d = Provider.of<DownloadProvider>(context);

    return PlayerBuilder.isPlaying(
      player: p.player,
      builder: (context, isPlaying) {
        return Column(children: <Widget>[
          ListTile(
            onTap: () {
              p.setBuffering(widget.index);
              p.isTrackInProgress(widget.track) ||
                      p.isLocalTrackInProgress(widget.track.localPath)
                  ? Navigator.of(context).pushNamed(AppRoutes.player)
                  : p.handlePlayButton(
                      track: widget.track,
                      index: widget.index,
                      album: widget.album,
                    );
            },
            title: Text(
              widget.track.title,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            subtitle: Row(
              children: [
                Text(
                  'Hassan Khaire',
                  style: TextStyle(
                      fontSize: 10.0,
                      color: Theme.of(context).colorScheme.primaryVariant),
                ),
                SizedBox(width: 10),
                Icon(
                  AntDesign.clockcircleo,
                  size: 10,
                ),
                SizedBox(width: 5),
                Text(
                  DateFormat('dd/MMM/yyyy').format(
                    DateTime.parse(widget.track.time),
                  ),
                  style: TextStyle(
                      fontSize: 10.0,
                      color: Theme.of(context).colorScheme.primaryVariant),
                ),
              ],
            ),
            leading: TrackPlayButton(
              track: widget.track,
              index: widget.index,
              album: widget.album,
            ),
            trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // if (widget.track.cover != null)
                  //   BaseImage(
                  //     heroId: widget.track.id,
                  //     imageUrl: widget.track.cover != null
                  //         ? widget.track.cover
                  //         : widget.album.cover,
                  //     height: 30,
                  //     width: 30,
                  //     radius: 5.0,
                  //   ),
                  TrackFavouriteButton(
                    track: widget.track,
                    iconSize: 14.0,
                  ),
                  TrackTileActions(
                    child: Icon(
                      Icons.more_vert,
                      color: Theme.of(context).primaryColor,
                    ),
                    track: widget.track,
                    title: $t(context, 'view_detail'),
                    isRemove: widget.isDownloadTile == null
                        ? false
                        : widget.isDownloadTile,
                  ),
                ]),
          ),
          Divider(
            color: Theme.of(context).cardColor,
            height: 0,
          ), //
        ]);
      },
    );
  }
}
