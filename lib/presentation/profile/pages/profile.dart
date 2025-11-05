import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:songify/common/helpers/is_dark_mode.dart';
import 'package:songify/common/widgets/appbar/app_bar.dart';
import 'package:songify/common/widgets/favorite_button/favorite_button.dart';
import 'package:songify/core/configs/theme/app_colors.dart';
import 'package:songify/presentation/profile/bloc/favorite_songs_cubit.dart';
import 'package:songify/presentation/profile/bloc/favorite_songs_state.dart';
import 'package:songify/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:songify/presentation/profile/bloc/profile_info_state.dart';
import 'package:songify/presentation/song_player/pages/song_player.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        backgroundColor: AppColors.darkGrey,
        title: Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _profileinfo(context),
            SizedBox(height:10),
            _favoriteSongs(),
          ],
        ),
      ),
    );
  }

  Widget _profileinfo(BuildContext context){
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        height: MediaQuery.of(context).size.height / 3.3,
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.isDarkMode ? AppColors.darkGrey : Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50),
            bottomRight: Radius.circular(50),
          ),
        ),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
        builder: (context, state){
          if(state is ProfileInfoLoading){
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator()
            );
          }
          if(state is ProfileInfoLoaded){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        state.userEntity.imageURL!
                      )
                    )
                  ),
                ),
                const SizedBox(height: 15,),
                Text(
                  state.userEntity.email!
                ),
                const SizedBox(height: 5,),
                Text(
                  state.userEntity.fullName!,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                )

              ],
            );
          }
          if (state is ProfileInfoFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 40),
                  const SizedBox(height: 8),
                  Text(
                    'Error: ${state.message}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: context.isDarkMode ? Colors.white70 : Colors.black87,
                      fontWeight: FontWeight.w600
                    )
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Please try logging in again.',
                    style: TextStyle(fontSize: 12)
                  )
                ],
              )
            );
          }
          return Container();
        }
      )
      ),
    );
  }

  Widget _favoriteSongs(){
    return BlocProvider(
      create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Text(
              'Favorite Songs',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 15),
            BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
              builder: (context,state){
                if(state is FavoriteSongsLoading){
                  return const CircularProgressIndicator();
                }
                if(state is FavoriteSongsLoaded){
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      final imageUrl = state.favoriteSongs[index].coverImageUrl;
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => SongPlayerPage(songEntity: state.favoriteSongs[index])
                            )
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(imageUrl)
                                    )
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.favoriteSongs[index].title, //align to the start
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16
                                      ),
                                              
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      state.favoriteSongs[index].artist,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11
                                      )
                                    ),
                                  ],
                                )
                              ]
                            ),
                            Row(
                              children: [
                                Text(
                                  state.favoriteSongs[index].duration.toString().replaceAll('.', ':')
                                ),
                                const SizedBox(width: 0),
                                GestureDetector(
                        
                                  child: FavoriteButton(
                                    songEntity: state.favoriteSongs[index],
                                    key: UniqueKey(),
                                    function: (){
                                      context.read<FavoriteSongsCubit>().removeSong(index);
                                    }
                                  )
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 20),
                    itemCount: state.favoriteSongs.length,
                  );
                }
                if(state is FavoriteSongsFailure){
                  return Text(
                    'Please try again.'
                  );
                }
                return Container();
              },
            )
            
          ],
        ),
      ),
    );
  }
}