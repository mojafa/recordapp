import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:record_app/models/Album.dart';
import 'package:record_app/models/Track.dart';

class MediaProvider with ChangeNotifier {
  List<Track> _tracks = [];
  List<Track> get tracks => _tracks;
  bool isInit = false;

  Future<void> uploadMedia(Album album) async {
    await FirebaseFirestore.instance
        .collection('albums')
        .doc()
        .set(album.toJson());
    notifyListeners();
  }

  Future<void> getAllTracks() async {
    if (isInit) {
      return;
    }
    final results = await FirebaseFirestore.instance.collection('albums').get();

    for (var result in results.docs) {
      final track = Track.fromJson(result.data());
      _tracks.add(track);
    }
    isInit = true;
    print('done');
    print(_tracks.length);
    notifyListeners();
  }
}
