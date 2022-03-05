import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:record_app/models/Album.dart';

class MediaProvider with ChangeNotifier {
  Future<void> uploadMedia(Album album) async {
    await FirebaseFirestore.instance
        .collection('albums')
        .doc()
        .set(album.toJson());
    notifyListeners();
  }
}
