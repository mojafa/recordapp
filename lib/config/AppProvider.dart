import 'package:record_app/providers/AlbumProvider.dart';
import 'package:record_app/providers/AuthProvider.dart';
import 'package:record_app/providers/DownloadProvider.dart';

import 'package:record_app/providers/TrackProvider.dart';
import 'package:record_app/providers/ThemeProvider.dart';
import 'package:record_app/providers/FavoriteProvider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:record_app/providers/PlayerProvider.dart';
import 'package:record_app/providers/media_provider.dart';

/*
 *  Providers
 * 
 *  List of provider that we want to init on app start
 *  you can add or remove provider according to your 
 *  requirments. Or you can use provider on any build
 *  widget. Please check providers docs for more details
 *   
 *  https://pub.dev/packages/provider
 */

List<SingleChildWidget> providers() {
  return [
    ChangeNotifierProvider<PlayerProvider>(
      create: (_) => PlayerProvider(),
    ),
    ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider(),
    ),
    ChangeNotifierProvider<AlbumProvider>(
      create: (context) => AlbumProvider(),
    ),
    ChangeNotifierProvider<TrackProvider>(
      create: (context) => TrackProvider(),
    ),
    ChangeNotifierProvider<MediaProvider>(
      create: (_) => MediaProvider(),
    ),
    ChangeNotifierProvider<AuthenticationProvider>(
      create: (context) => AuthenticationProvider(),
    ),
    ChangeNotifierProvider<ThemeProvider>(
      create: (context) => ThemeProvider(),
    ),
    ChangeNotifierProvider<FavoriteProvider>(
      create: (context) => FavoriteProvider(),
    ),
    ChangeNotifierProvider<DownloadProvider>(
      create: (context) => DownloadProvider(),
    ),
  ];
}
