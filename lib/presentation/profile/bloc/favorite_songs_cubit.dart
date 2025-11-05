import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:songify/domain/entities/song/song_entity.dart';
import 'package:songify/domain/usecases/song/get_favorite_songs.dart';
import 'package:songify/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:songify/service_locator.dart';

class FavoriteSongsCubit extends Cubit<FavoriteSongsState>{
  FavoriteSongsCubit() : super(FavoriteSongsLoading()); //inital state


  List<SongEntity> favoriteSongs = []; 

  Future<void> getFavoriteSongs() async {
    var result = await sl<GetFavoriteSongsUseCase>().call();

    result.fold(
      (l){
        emit(
          FavoriteSongsFailure()
        );
      },
      (r){
        favoriteSongs = r;
        emit(
          FavoriteSongsLoaded(favoriteSongs: favoriteSongs) //parameter : value (just named the same)
        );
      }
    );
  }
  void removeSong(int index){
    favoriteSongs.removeAt(index);
    emit(
      FavoriteSongsLoaded(favoriteSongs: favoriteSongs)
    );
  }
}

