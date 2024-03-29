import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:record_app/config/AppColors.dart';
import 'package:record_app/config/AppRoutes.dart';
import 'package:record_app/models/Track.dart';
import 'package:record_app/providers/PlayerProvider.dart';
import 'package:record_app/widgtes/common/BaseImage.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'TrackPlayButton.dart';

class TrackBottomBar extends StatefulWidget {
  TrackBottomBar({Key key}) : super(key: key);

  @override
  _TrackBottomBarState createState() => _TrackBottomBarState();
}

class _TrackBottomBarState extends State<TrackBottomBar>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 10))
          ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PlayerProvider playerProvider =
        Provider.of<PlayerProvider>(context, listen: false);
    Track track;
    return PlayerBuilder.realtimePlayingInfos(
      player: playerProvider.player,
      builder: (context, infos) {
        track = playerProvider.currentTrack;

        return track != null
            ? GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.player),
                child: Container(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AnimatedBuilder(
                                animation: _controller,
                                builder: (_, child) {
                                  double _angle = _controller.value * 2 * pi;
                                  if (!playerProvider.isPlaying()) {
                                    _angle = 0.0;
                                  }

                                  return Transform.rotate(
                                    angle: _angle,
                                    child:
                                        playerProvider.getTrackThumbnail != null
                                            ? BaseImage(
                                                imageUrl: playerProvider
                                                    .getTrackThumbnail(),
                                                width: 30,
                                                height: 30,
                                                radius: 100,
                                              )
                                            : Icon(
                                                Icons.disc_full,
                                                size: 30,
                                              ),
                                  );
                                }),
                            SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(track.title,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 14)),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Hassan Ali Khaire',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(SimpleLineIcons.control_rewind),
                                  iconSize: 20,
                                  color: playerProvider.isFirstTrack()
                                      ? Theme.of(context).iconTheme.color
                                      : Theme.of(context).primaryColor,
                                  onPressed: () {
                                    playerProvider.prev();
                                    setState(() {});
                                  },
                                ),
                                TrackPlayButton(
                                  track: track,
                                  isBottom: true,
                                  onPressed: () {
                                    playerProvider.playOrPause();
                                    setState(() {});
                                  },
                                ),
                                IconButton(
                                  icon: Icon(SimpleLineIcons.control_forward),
                                  color: playerProvider.isLastTrack(
                                          playerProvider.currentIndex + 1)
                                      ? Theme.of(context).iconTheme.color
                                      : Theme.of(context).primaryColor,
                                  iconSize: 20,
                                  onPressed: () {
                                    if (playerProvider.isLastTrack(
                                        playerProvider.currentIndex + 1))
                                      return;
                                    playerProvider.next();
                                    setState(() {});
                                  },
                                ),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (playerProvider.isPlaying())
                                          playerProvider.handlePlayButton(
                                            track: track,
                                            album: playerProvider.currentAlbum,
                                            index: playerProvider.currentIndex,
                                          );
                                        playerProvider.setCurrentTrack = null;
                                      });
                                    },
                                    child: Icon(Icons.close, color: primary)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (infos != null)
                        LinearProgressIndicator(
                          minHeight: 1,
                          value: !playerProvider.isPlaying()
                              ? 0.0
                              : infos.currentPosition.inMilliseconds /
                                  infos.duration.inMilliseconds,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          valueColor: new AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor),
                        ),
                    ], // ),
                  ),
                ),
              )
            : Container();
      },
    );
  }
}
