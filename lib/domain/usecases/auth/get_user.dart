import 'package:dartz/dartz.dart';
import 'package:songify/core/usecase/usecase.dart';
import 'package:songify/domain/repository/auth/auth.dart';

class GetUserUseCase implements UseCase<Either,dynamic>{
  final AuthRepository _authRepository;
  GetUserUseCase(this._authRepository); 

  @override
  Future<Either> call({params}) async {
    return await _authRepository.getUser();
  }
}