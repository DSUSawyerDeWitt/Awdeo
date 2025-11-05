import 'package:songify/domain/entities/auth/user.dart';

class UserModel{
  String ? fullName;
  String ? email;
  String ? imageURL;

  UserModel(
    {
      this.fullName,
      this.email,
      this.imageURL,
    }
  );

  factory UserModel.fromJson(Map<String, dynamic> data ){
    return UserModel(
      fullName: data['name'] as String?,
      email: data['email'] as String?,
    );
  }
}


extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      email: email, 
      fullName: fullName,
      imageURL: imageURL,
    );
  }
}