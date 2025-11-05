import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:songify/domain/entities/song/song_entity.dart';

class SongModel{
  String ? title;
  String ? artist;
  num ? duration;
  Timestamp ? releaseDate;
  String ? coverImageUrl;
  String ? songUrl;
  bool ? isFavorite;
  String ? songId;

  SongModel({    
    required this.title, 
    required this.artist, 
    required this.duration, 
    required this.releaseDate,
    required this.coverImageUrl,
    required this.songUrl,
    required this.isFavorite,
    required this.songId,
  });

  SongModel.fromJson(Map<String, dynamic> data ){
    title = data['title'];
    artist = data['artist'];
    duration = data['duration'];
    releaseDate = data['releaseDate'];
    coverImageUrl = data['coverImageUrl'];
    songUrl = data['songUrl'];
  }
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      title: title!, 
      artist: artist!, 
      duration: duration!, 
      releaseDate: releaseDate!,
      coverImageUrl: coverImageUrl!,
      songUrl: songUrl!,
      isFavorite: isFavorite!,
      songId: songId!,
    );
  }
}