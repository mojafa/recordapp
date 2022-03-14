import 'package:flutter/material.dart';
import 'package:record_app/mixins/BaseMixins.dart';
import 'package:record_app/models/Album.dart';
import 'package:record_app/providers/DownloadProvider.dart';
import 'package:record_app/widgtes/Common/BaseAppBar.dart';
import 'package:record_app/widgtes/Common/BaseScreenHeading.dart';
import 'package:record_app/widgtes/Common/CustomCircularProgressIndicator.dart';
import 'package:record_app/widgtes/Search/BaseMessageScreen.dart';
import 'package:record_app/widgtes/track/TrackTile.dart';
import 'package:provider/provider.dart';

class DownloadScreen extends StatelessWidget with BaseMixins {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(50),
      //   child: BaseAppBar(),
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          BaseScreenHeading(title: $t(context, 'download')),
          Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Spacer(),
                InkWell(
                    onTap: () {
                      final download =
                          Provider.of<DownloadProvider>(context, listen: false);

                      for (int i = 0; i < download.downloadSongs.length; i++) {
                        download.removeSong(download.downloadSongs[i]);
                      }
                    },
                    child:
                        Text('Clear All', style: TextStyle(color: Colors.red))),
                SizedBox(width: 15),
              ],
            ),
          ),
          Expanded(
              child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: TrackContainer(),
          )),
        ],
      ),
    );
  }
}

class TrackContainer extends StatelessWidget with BaseMixins {
  @override
  Widget build(BuildContext context) {
    DownloadProvider downloadProvider = Provider.of<DownloadProvider>(context);

    return Container(
        padding: EdgeInsets.only(bottom: 0.0),
        child: downloadProvider.downloadSongs.length > 0
            ? downloadProvider.isLoaded
                ? ListView.builder(
                    itemCount: downloadProvider.downloadSongs.length,
                    itemBuilder: (context, index) {
                      Album album = new Album(null, $t(context, 'download'),
                          null, null, downloadProvider.downloadSongs);
                      return TrackTile(
                          track: album.tracks[index],
                          index: index,
                          album: album,
                          isDownloadTile: true);
                    },
                  )
                : CustomCircularProgressIndicator()
            : BaseMessageScreen(
                title: $t(context, 'download_error2'),
                icon: Icons.data_usage,
                subtitle: '',
              ));
  }
}
