abstract class SongPlayerState {
  const SongPlayerState();
}

class SongPlayerLoading extends SongPlayerState {}

class SongPlayerFailure extends SongPlayerState {}

class SongPlayerLoaded extends SongPlayerState {
  final Duration position;
  final Duration duration;
  final bool isPlaying;

  // 1. ADD CONSTRUCTOR
  const SongPlayerLoaded({
    required this.position,
    required this.duration,
    required this.isPlaying,
  });

  // 2. ADD copyWith METHOD
  SongPlayerLoaded copyWith({
    Duration? position,
    Duration? duration,
    bool? isPlaying,
  }) {
    return SongPlayerLoaded(
      position: position ?? this.position,
      duration: duration ?? this.duration,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}
