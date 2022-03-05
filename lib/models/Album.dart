import 'package:record_app/models/Track.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Album.g.dart';

@JsonSerializable(explicitToJson: true)
class Album {
  final int id;
  final String title;
  String cover;
  final String content;
  final List<Track> tracks;

  Album(this.id, this.title, this.content, this.cover, this.tracks);
  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}
