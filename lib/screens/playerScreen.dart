import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:record_app/config/AppColors.dart';
import 'package:record_app/mixins/BaseMixins.dart';
import 'package:record_app/models/Track.dart';
import 'package:record_app/providers/DownloadProvider.dart';
import 'package:record_app/providers/PlayerProvider.dart';
import 'package:record_app/screens/Track/TrackDetailsScreen.dart';
import 'package:record_app/screens/up_next.dart';
import 'package:record_app/widgtes/Common/Animations/AnimationRotate.dart';
import 'package:record_app/widgtes/Common/BaseImage.dart';
import 'package:record_app/widgtes/PositionSeekWidget.dart';
import 'package:record_app/widgtes/Track/TrackTileActions.dart';
import 'package:record_app/widgtes/track/TrackFavouriteButton.dart';
import 'package:provider/provider.dart';

class PlayerScreen extends StatelessWidget with BaseMixins {
  @override
  Widget build(BuildContext context) {
    Track track;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var playerProvider = Provider.of<PlayerProvider>(context);

    playerProvider.audioSessionListener();
    return Scaffold(
      body: PlayerBuilder.realtimePlayingInfos(
        player: playerProvider.player,
        builder: (context, infos) {
          track = playerProvider.currentTrack;

          return Stack(
            children: [
              SingleChildScrollView(
                  child: Column(
                children: [
                  buildTopContainer(
                      height, playerProvider, width, context, track),
                  SizedBox(height: height * 0.02),
                  buildTrackProgreesSlider(infos, track, playerProvider),
                  SizedBox(height: height * 0.03),
                  buildPlayerActions(height, playerProvider, context, width),
                  SizedBox(height: height * 0.03),
                  buildPlayerBttomActions(context, playerProvider, track),
                  width > 500
                      ? SizedBox(
                          height: 5,
                        )
                      : SizedBox(height: height * 0.05),
                ],
              )),
              UpNextWidget()
            ],
          );
        },
      ),
    );
  }

  Widget buildTrackProgreesSlider(
      RealtimePlayingInfos infos, Track track, PlayerProvider playerProvider) {
    return infos != null
        ? PositionSeekWidget(
            currentPosition: infos.currentPosition,
            duration: track.time == 'Live'
                ? Duration(hours: 1, minutes: 3) //just a dummy time if stream
                : infos.duration,
            seekTo: (to) {
              playerProvider.player.seek(to);
            },
          )
        : Container();
  }

  Container buildTopContainer(double height, PlayerProvider playerProvider,
      double width, BuildContext context, Track track) {
    var isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Container(
      height: isLandscape ? height / 1.35 : height / 2,
      child: Stack(
        children: <Widget>[
          if (playerProvider.getTrackCover != null)
            BaseImage(
              imageUrl: playerProvider.getTrackCover(),
              width: width,
              height: height,
              radius: 0,
              overlay: true,
              overlayOpacity: 0.1,
              overlayStops: [0.0, 0.9],
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: height * 0.07),
                  Container(
                    margin: EdgeInsets.only(right: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              $t(context, 'now_playing'),
                              style: TextStyle(fontSize: 19),
                            ),
                            SizedBox(height: 5),
                            Text(playerProvider.currentAlbum.title,
                                style: TextStyle()),
                          ],
                        ),
                        Expanded(
                          child: TrackTileActions(
                            track: playerProvider.currentTrack,
                            title: $t(context, 'view_detail'),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  if (playerProvider.getTrackThumbnail != null)
                    AnimationRotate(
                      stop: !playerProvider.isPlaying(),
                      child: BaseImage(
                        imageUrl: playerProvider.getTrackThumbnail(),
                        width: 150,
                        height: 150,
                        radius: 100,
                      ),
                    ),
                  SizedBox(height: 15),
                  Text(
                    track.title,
                    style: TextStyle(fontSize: height * 0.025),
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    'Hassan Khaire',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 6.0),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Row buildPlayerActions(double height, PlayerProvider playerProvider,
      BuildContext context, double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(SimpleLineIcons.control_rewind),
          iconSize: height * 0.04,
          color: playerProvider.isFirstTrack()
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).primaryColor,
          onPressed: () {
            playerProvider.prev();
          },
        ),
        SizedBox(width: width * 0.09),
        PlayerBuilder.isPlaying(
            player: playerProvider.player,
            builder: (context, isPlaying) {
              return RawMaterialButton(
                elevation: 2.0,
                fillColor: Theme.of(context).primaryColor,
                child: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
                onPressed: () async {
                  playerProvider.playOrPause();
                },
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
              );
            }),
        SizedBox(width: width * 0.09),
        IconButton(
          icon: Icon(SimpleLineIcons.control_forward),
          color: playerProvider.isLastTrack(playerProvider.currentIndex + 1)
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).primaryColor,
          iconSize: height * 0.04,
          onPressed: () {
            if (playerProvider.isLastTrack(playerProvider.currentIndex + 1))
              return;
            playerProvider.next(action: false);
          },
        )
      ],
    );
  }

  Row buildPlayerBttomActions(
      BuildContext context, PlayerProvider playerProvider, Track track) {
    DownloadProvider downloadProvider = Provider.of<DownloadProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
          onPressed: () {
            downloadProvider.isDownloadSong(track)
                ? downloadProvider.removeSong(track)
                : downloadProvider.downloadAudio(
                    track, context, playerProvider.currentAlbum);
            ;
          },
          icon: Icon(
            FlutterIcons.download_cloud_fea,
            size: 30,
            color: downloadProvider.isDownloadSong(track) ? primary : null,
          ),
        ),
        TrackFavouriteButton(track: track),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    TrackDetailsScreen(track: track),
              ),
            );
          },
          icon: Icon(
            Icons.subtitles_outlined,
            size: 30,
          ),
        ),
      ],
    );
  }
}
