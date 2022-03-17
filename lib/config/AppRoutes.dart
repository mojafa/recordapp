/*
 * AppRoutes
 * 
 * Define all routes for our app. We can access route
 * name as [AppRoutes.myRouteName]  anywhere in our app
 * Add or remove routes according to your requiremnts
 *  
 */

import 'package:flutter/material.dart';

import 'package:record_app/screens/DownloadScreen.dart';
import 'package:record_app/screens/HomeScreen.dart';
import 'package:record_app/screens/album/AlbumDetailScreen.dart';
import 'package:record_app/screens/album/AlbumsScreen.dart';
import 'package:record_app/screens/PlayerScreen.dart';

class AppRoutes {
  static const home = '/home';
  static const albums = '/albums';
  static const albumDetail = '/album';
  static const post = '/post';
  static const posts = '/posts';
  static const podcasts = '/podcasts';
  static const artists = '/artists';
  static const artist = '/artist';
  static const player = '/player';
  static const loginRoute = '/loginRoute';
  static const registerRoute = '/registerRoute';
  static const profileEditRoute = '/profileEditRoute';
  static const confirmScreenRoute = '/confirmScreenRoute';
  static const downloadScreenRoute = '/downloadScreenRoute';

  Map<String, WidgetBuilder> routes() {
    return {
      home: (context) => MyBottomNav(),
      albums: (context) => AlbumsScreen(),
      albumDetail: (context) => AlbumDetailScreen(),
      player: (context) => PlayerScreen(),
      downloadScreenRoute: (context) => DownloadScreen()
    };
  }
}
