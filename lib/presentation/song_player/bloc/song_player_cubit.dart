import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:songify/presentation/song_player/bloc/song_player_state.dart';

class SongPlayerCubit extends Cubit<SongPlayerState>{
  final AudioPlayer audioPlayer = AudioPlayer();

  Duration songDuration = Duration.zero; 
  Duration songPosition = Duration.zero;
  bool isPlaying = false; 

  SongPlayerCubit() : super(SongPlayerLoading()) {
    
    // Listen to position stream (frequent updates for slider)
    audioPlayer.positionStream.listen((position){
      songPosition = position;
      if (state is SongPlayerLoaded) {
          emit((state as SongPlayerLoaded).copyWith(
              position: position,
          ));
      }
    });

    // Listen to duration stream (less frequent, updates total time)
    audioPlayer.durationStream.listen((duration){
      songDuration = duration ?? Duration.zero;
      if (state is SongPlayerLoaded) {
          emit((state as SongPlayerLoaded).copyWith(
              duration: songDuration,
          ));
      }
    });
    
    // CRITICAL FIX: Listen to player state for stable UI rendering
    audioPlayer.playerStateStream.listen((playerState) {
        isPlaying = playerState.playing;
        
        // If loading or buffering, only update playing status if controls are visible
        if (playerState.processingState == ProcessingState.loading || 
            playerState.processingState == ProcessingState.buffering) 
        {
            if (state is SongPlayerLoaded) {
                emit((state as SongPlayerLoaded).copyWith(
                    isPlaying: isPlaying,
                ));
            }
        } 
        // If ready or in a stable state (idle/completed), show the controls
        else if (playerState.processingState == ProcessingState.ready || 
                 playerState.processingState == ProcessingState.completed ||
                 playerState.processingState == ProcessingState.idle) 
        {
            emit(SongPlayerLoaded(
                position: audioPlayer.position,
                duration: audioPlayer.duration ?? Duration.zero,
                isPlaying: audioPlayer.playing,
            ));
        }
    });
  }

  Future<void> loadSong(String url) async{
    emit(SongPlayerLoading());
    try{
      await audioPlayer.setUrl(url);
    } catch(e){
      emit(
        SongPlayerFailure()
      );
    }
  }

  void playOrPauseSong(){
    if(audioPlayer.playing){
      audioPlayer.pause(); // Fixed: use pause()
    }
    else{
      audioPlayer.play();
    }
    // State emission is handled by the playerStateStream listener.
  }

  Future<void> seek(Duration position) async {
    await audioPlayer.seek(position);
    // Optional: Emit immediately after seek for snappy UI update
    if (state is SongPlayerLoaded) {
      emit((state as SongPlayerLoaded).copyWith(
        position: position,
      ));
    }
  }

  @override
  Future<void> close(){
    audioPlayer.dispose();
    return super.close();
  }
}