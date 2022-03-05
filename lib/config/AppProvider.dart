import 'package:record_app/providers/AlbumProvider.dart';
import 'package:record_app/providers/ArtistProvider.dart';
import 'package:record_app/providers/AuthProvider.dart';
import 'package:record_app/providers/DownloadProvider.dart';
import 'package:record_app/providers/ExploreProvider.dart';
import 'package:record_app/providers/PodcastProvider.dart';
import 'package:record_app/providers/PostProvider.dart';
import 'package:record_app/providers/TrackProvider.dart';
import 'package:record_app/providers/UsersProvider.dart';
import 'package:record_app/providers/ThemeProvider.dart';
import 'package:record_app/providers/FavoriteProvider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:record_app/providers/PlayerProvider.dart';
import 'package:record_app/providers/auth_provider.dart';
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
    ChangeNotifierProvider<AuthProvider>(
      create: (_) => AuthProvider(),
    ),
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
    ChangeNotifierProvider<ExploreProvider>(
      create: (context) => ExploreProvider(),
    ),
    ChangeNotifierProvider<ArtistProvider>(
      create: (context) => ArtistProvider(),
    ),
    ChangeNotifierProvider<UsersProvider>(
      create: (context) => UsersProvider(),
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
    ChangeNotifierProvider<PodcastProvider>(
      create: (context) => PodcastProvider(),
    ),
    ChangeNotifierProvider<PostProvider>(
      create: (context) => PostProvider(),
    ),
  ];
}
