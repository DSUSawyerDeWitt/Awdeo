import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:songify/domain/usecases/song/get_news_songs.dart';
import 'package:songify/presentation/home/bloc/news_songs_state.dart';

import '../../../service_locator.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {

  NewsSongsCubit() : super(NewsSongsLoading()); //Cubit inital state set the Loading

  Future<void> getNewsSongs() async {
    var returnedSongs = await sl<GetNewsSongsUseCase>().call();

    returnedSongs.fold(
      (l) {
        emit(NewsSongsLoadFailure());
      },
      (data) {
        emit(NewsSongsLoaded(songs:data));
      }
    );
  }
}