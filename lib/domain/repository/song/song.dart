import 'package:dartz/dartz.dart';

abstract class SongsRepository{
  Future<Either> getNewSongs(); //
  Future<Either> getPlayList(); //fetch all the songs from firestore.
  Future<Either> addOrRemoveFavoriteSong(String songId);
  Future<bool> isFavoriteSong(String songId);
  Future<Either> getUserFavoriteSongs();
}