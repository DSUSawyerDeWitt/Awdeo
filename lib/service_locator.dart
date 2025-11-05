import 'package:get_it/get_it.dart';
import 'package:songify/data/repository/auth/auth_repository_impl.dart';
import 'package:songify/data/sources/auth/auth_firebase_service.dart';
import 'package:songify/domain/repository/auth/auth.dart';
import 'package:songify/domain/usecases/auth/get_user.dart';
import 'package:songify/domain/usecases/auth/signup_usecase.dart';
import 'package:songify/domain/usecases/song/add_or_remove_favorite_song.dart';
import 'package:songify/domain/usecases/song/get_favorite_songs.dart';
import 'package:songify/domain/usecases/song/get_news_songs.dart';
import 'package:songify/domain/usecases/song/get_play_list.dart';
import 'package:songify/domain/usecases/song/is_favorite_song.dart';

import 'data/repository/song/song_repository_impl.dart';
import 'data/sources/songs/song_firebase_service.dart';
import 'domain/repository/song/song.dart';
import 'domain/usecases/auth/signin_usecase.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  sl.registerSingleton<AuthFirebaseService>(
    AuthFireBaseServiceImpl()
  );

  sl.registerSingleton<SongFirebaseService>(
    SongFirebaseServiceImpl()
  );

  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl()
  );

  sl.registerSingleton<SongsRepository>(
    SongRepositoryImpl(sl<SongFirebaseService>())
  );

  sl.registerSingleton<SignupUseCase>(
    SignupUseCase()
  );

  sl.registerSingleton<SigninUseCase>(
    SigninUseCase()
  ); 

  sl.registerSingleton<GetNewsSongsUseCase>(
    GetNewsSongsUseCase(sl<SongsRepository>())
  );

  sl.registerSingleton<GetPlayListUseCase>(
    GetPlayListUseCase(sl<SongsRepository>())
  ); 

  sl.registerSingleton<AddOrRemoveFavoriteSongUseCase>(
    AddOrRemoveFavoriteSongUseCase()
  ); 

  sl.registerSingleton<IsFavoriteSongUseCase>(
    IsFavoriteSongUseCase()
  ); 

  sl.registerSingleton<GetUserUseCase>(
    GetUserUseCase(sl<AuthRepository>()) 
  );

  sl.registerSingleton<GetFavoriteSongsUseCase>(
    GetFavoriteSongsUseCase(sl<SongsRepository>()) 
  );
}
