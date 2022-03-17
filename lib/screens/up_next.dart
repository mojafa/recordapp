import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:record_app/config/AppColors.dart';
import 'package:record_app/models/Album.dart';
import 'package:record_app/providers/PlayerProvider.dart';
import 'package:record_app/widgtes/track/TrackTile.dart';

class UpNextWidget extends StatelessWidget {
  const UpNextWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PlayerProvider playerProvider = Provider.of<PlayerProvider>(context);
    final album = playerProvider.currentAlbum;
    return GestureDetector(
      // behavior: HitTestBehavior.opaque,
      // onTap: () => Navigator.of(context).pop(),
      child: GestureDetector(
        onTap: () {},
        child: DraggableScrollableSheet(
          initialChildSize: 0.1,
          maxChildSize: 0.5,
          minChildSize: 0.1,
          builder: (ctx, controller) => AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: ListView(
                  shrinkWrap: true,
                  controller: controller,
                  padding: EdgeInsets.zero,
                  // physics: NeverScrollableScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Container(
                            width: 50,
                            height: 5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).iconTheme.color),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Up Next',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    ListView(
                      padding: EdgeInsets.zero,
                      controller: controller,
                      shrinkWrap: true,
                      children: album.tracks
                          .map((e) => Container(
                                color: playerProvider.currentTrack == e
                                    ? primary.withOpacity(0.5)
                                    : Theme.of(context)
                                        .scaffoldBackgroundColor
                                        .withOpacity(0.05 *
                                            (album.tracks.indexOf(e) + 1)),
                                child: TrackTile(
                                  album: album,
                                  index: album.tracks.indexOf(e),
                                  track: e,
                                  tracks: album.tracks,
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
