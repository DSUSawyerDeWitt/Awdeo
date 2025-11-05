import 'package:cloud_firestore/cloud_firestore.dart';

class SongEntity{
  final String title;
  final String artist;
  final num duration;
  final Timestamp releaseDate;
  final String coverImageUrl;
  final String songUrl;
  final bool isFavorite;
  final String songId;

  SongEntity({    
    required this.title, 
    required this.artist, 
    required this.duration, 
    required this.releaseDate,
    required this.coverImageUrl,
    required this.songUrl,
    required this.isFavorite,
    required this.songId,
  });
}