import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:songify/common/helpers/is_dark_mode.dart';
import 'package:songify/common/widgets/favorite_button/favorite_button.dart';
import 'package:songify/core/configs/theme/app_colors.dart';
import 'package:songify/domain/entities/song/song_entity.dart';
import 'package:songify/presentation/home/bloc/play_list_cubit.dart';
import 'package:songify/presentation/home/bloc/play_list_state.dart';
import 'package:songify/presentation/song_player/pages/song_player.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlayListCubit()..getPlayList(),
      child: BlocBuilder<PlayListCubit, PlayListState>(
        builder: (context,state){
          if(state is PlayListLoading){
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }
          if(state is PlayListLoaded){
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 35,
                    left: 20,
                    right: 20 ,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'PlayList',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: context.isDarkMode ? const Color(0xffDBDBDB) : const Color(0xff131313)
                        )
                      ),    
                      Text(
                        'See More',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: context.isDarkMode ? const Color(0xffC6C6C6) : const Color(0xff131313)
                        )
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: _songs(state.songs),
                ),
              ],
            );
          }
          return Container();
        },
      )
    );
  }

  Widget _songs(List<SongEntity> songs){
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index){
        final currentSong = songs[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => SongPlayerPage(songEntity: songs[index]))
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.isDarkMode ? AppColors.darkGrey : Color(0xffE6E6E6)
                    ),
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        songs[index].title, //align to the start
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),
          
                      ),
                      SizedBox(height: 5),
                      Text(
                        songs[index].artist,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 11
                        )
                      )
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    songs[index].duration.toString().replaceAll('.', ':')
                  ),
                  const SizedBox(width: 15),
                  FavoriteButton(songEntity: currentSong)//songs[index])
                ],
              )
            ],
          ),
        );
      }, 
      separatorBuilder: (context, index) => const SizedBox(height: 20), 
      itemCount: songs.length
    );
  }
}