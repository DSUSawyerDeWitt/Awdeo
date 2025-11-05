import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:songify/common/helpers/is_dark_mode.dart';
import 'package:songify/common/widgets/appbar/app_bar.dart';
import 'package:songify/common/widgets/favorite_button/favorite_button.dart';
import 'package:songify/core/configs/theme/app_colors.dart';
import 'package:songify/domain/entities/song/song_entity.dart';
import 'package:songify/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:songify/presentation/song_player/bloc/song_player_state.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity;
  const SongPlayerPage({
    required this.songEntity,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: Text(
          'Now Playing',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: context.isDarkMode ? const Color(0xffDDDDDD) : const Color(0xff000000) 
          )
        ),
        action: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert_rounded
          )
        ),
      ),
      body: BlocProvider(
        create: (_) => SongPlayerCubit()..loadSong(
          songEntity.songUrl
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          child: Column(
            children: [
              _songCover(context),
              const SizedBox(height: 20),
              _songDetail(),
              const SizedBox(height: 30),
              _songPlayer(context),
            ],
          )
        ),
      )
    );
  }

  Widget _songCover(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height / 2.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            songEntity.coverImageUrl
          )
        )
      ),
    );
  }
  
  Widget _songDetail(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              songEntity.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24
              ),

            ),
            const SizedBox(height: 5),
            Text(
              songEntity.artist,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14
              )
            )
          ],
        ),
        FavoriteButton(
          songEntity: songEntity
        )
      ],
    );
  }

  Widget _songPlayer(BuildContext context){
    return BlocBuilder<SongPlayerCubit,SongPlayerState>(
      builder: (context, state){
        if(state is SongPlayerLoading){
          return const Center(child: CircularProgressIndicator());
        }
        if(state is SongPlayerLoaded){
          final currentPosition = state.position;
          final totalDuration = state.duration;
          final isPlaying = state.isPlaying;

          return Column(
            children: [
              // 1. Slider reads values from state for updates
              Slider(
                value: currentPosition.inSeconds.toDouble(),
                min: 0.0,
                max: totalDuration.inSeconds.toDouble(),
                activeColor: AppColors.primary,
                inactiveColor: AppColors.darkGrey,
                onChanged: (value){
                  // onChanged can be empty, or used for immediate UI feedback (advanced)
                },
                // 2. Seeking logic on drag end
                onChangeEnd: (value){
                  context.read<SongPlayerCubit>().seek(
                    Duration(seconds: value.toInt())
                  );
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 3. Time texts read from state
                  Text(
                    formatDuration(
                      currentPosition
                    )
                  ),
                  Text(
                    formatDuration(
                      totalDuration
                    )
                  )
                ],
              ),
              const SizedBox(height: 20),
              // 4. Play/Pause button logic
              GestureDetector(
                onTap: (){
                  context.read<SongPlayerCubit>().playOrPauseSong();
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: Icon(
                    isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              )
            ],
          );
        }
        
        // Optional: Add a case for SongPlayerFailure
        if (state is SongPlayerFailure) {
           return const Center(
             child: Text('Failed to load song. Please check the song URL.'),
           );
        }
        
        return Container();
      }
    );
  }

  String formatDuration(Duration duration){
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2,'0')}:${seconds.toString().padLeft(2,'0')}';
  }
}