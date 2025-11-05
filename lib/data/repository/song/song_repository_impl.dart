import 'package:dartz/dartz.dart';
import 'package:songify/data/sources/songs/song_firebase_service.dart';
import 'package:songify/domain/repository/song/song.dart';



class SongRepositoryImpl extends SongsRepository {
  final SongFirebaseService service;

  SongRepositoryImpl(this.service);

  @override
  Future<Either> getNewSongs() async {
    return await service.getNewsSongs();
  }
  
  @override
  Future<Either> getPlayList() async {
    return await service.getPlayList();
  }
  
  @override
  Future<Either> addOrRemoveFavoriteSong(String songId) async {
    return await service.addOrRemoveFavoriteSong(songId);
  }
  
  @override
  Future<bool> isFavoriteSong(String songId) async {
    return await service.isFavoriteSong(songId);
  }
  
  @override
  Future<Either> getUserFavoriteSongs() async {
    return await service.getUserFavoriteSongs();
  }
}