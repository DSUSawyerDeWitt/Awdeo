import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:songify/domain/entities/auth/user.dart'; // Import the entity
import 'package:songify/domain/usecases/auth/get_user.dart';
import 'package:songify/presentation/profile/bloc/profile_info_state.dart';
import 'package:songify/service_locator.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState>{
  ProfileInfoCubit() : super (ProfileInfoLoading());

  Future<void> getUser() async {
    emit(ProfileInfoLoading()); 
    var result = await sl<GetUserUseCase>().call(); 
    
    result.fold(
      (l){
        emit(
          ProfileInfoFailure(message: l.toString()) 
        );
      },
      (r){
        emit(
          ProfileInfoLoaded(userEntity: r as UserEntity)
        );
      },
    );
  }
}