import 'package:dartz/dartz.dart';
import 'package:songify/core/usecase/usecase.dart';
import 'package:songify/domain/repository/song/song.dart';


class GetPlayListUseCase implements UseCase<Either, dynamic> {
  final SongsRepository repository;

  GetPlayListUseCase(this.repository);

  @override
  Future<Either> call({params}) async {
    return await repository.getPlayList();
  }
}