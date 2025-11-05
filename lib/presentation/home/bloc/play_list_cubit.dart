import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:songify/domain/usecases/song/get_play_list.dart';
import 'package:songify/presentation/home/bloc/play_list_state.dart';

import '../../../service_locator.dart';

class PlayListCubit extends Cubit<PlayListState> {

  PlayListCubit() : super(PlayListLoading()); //Cubit inital state set the Loading

  Future<void> getPlayList() async {
    var returnedSongs = await sl<GetPlayListUseCase>().call();

    returnedSongs.fold(
      (l) {
        emit(PlayListLoadFailure());
      },
      (data) {
        emit(PlayListLoaded(songs:data));
      }
    );
  }
}