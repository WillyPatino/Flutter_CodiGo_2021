import 'dart:convert';

import 'package:spotifyapi/models/playlist.dart';

import 'artists.dart';

Busqueda busquedaFromJson(String str) => Busqueda.fromJson(json.decode(str));

String busquedaToJson(Busqueda data) => json.encode(data.toJson());

class Busqueda {
  Busqueda({
    this.artists,
    this.playlists,
  });

  Artists artists;
  Playlists playlists;

  factory Busqueda.fromJson(Map<String, dynamic> json) => Busqueda(
      artists: json["artists"] == null ? null : Artists.fromJson(json["artists"]),
      playlists: json["playlist"] == null? null: Playlists.fromJson(json["playlists"]));

  Map<String, dynamic> toJson() => {
        "artists": artists == null ? null : artists.toJson(),
        "playlists": playlists == null ? null : playlists.toJson(),
      };
}
