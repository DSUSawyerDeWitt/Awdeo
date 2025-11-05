import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:songify/data/models/auth/create_user_req.dart';
import 'package:songify/data/models/auth/signin_user_req.dart';
import 'package:songify/data/models/auth/user.dart';
import 'package:songify/domain/entities/auth/user.dart';

abstract class AuthFirebaseService {

  Future<Either> signup(CreateUserReq createUserReq);

  Future<Either> signin(SigninUserReq signinUserReq);

  Future<Either> getUser();
}

class AuthFireBaseServiceImpl extends AuthFirebaseService{

  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signinUserReq.email, 
        password: signinUserReq.password,
      );

      return const Right('Signin was Successful');

    } on FirebaseAuthException catch(e){
      String message = '';
      if (e.code == 'invalid-email'){
        message = 'Email is not formatted correctly';
      } else if (e.code == 'invalid-credential'){
        message = 'Email or Password is Incorrect.';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async{
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email, 
        password: createUserReq.password
      );

      FirebaseFirestore.instance.collection('Users').doc(data.user?.uid)
      .set(
        {
          'name' : createUserReq.fullName,
          'email': data.user?.email,
        }
      );

      return const Right('Signup was Successful');

    } on FirebaseAuthException catch(e){
      String message = '';
      if (e.code == 'email-already-in-use'){
        message = 'An account already exists with that email.';
      } else if (e.code == 'weak-password'){
        message = 'The password provided is too weak';
      }
      return Left(message);
    }
  }
  
  @override
  Future<Either> getUser() async {

    String defaultIconPicture = 'https://firebasestorage.googleapis.com/v0/b/songify22.firebasestorage.app/o/icons%2Fdefault_profile_icon.png?alt=media';

    try{
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
 
    final uid = firebaseAuth.currentUser?.uid;
    if(uid == null){
      return const Left('User is not logged in.');
    }
    final userSnapshot = await firebaseFirestore.collection('Users').doc(uid).get();
    if (!userSnapshot.exists || userSnapshot.data() == null) {
      return const Left('User profile data not found in Firestore');
    }
    final data = userSnapshot.data()!;

    UserModel userModel = UserModel.fromJson(data);

    userModel.imageURL = firebaseAuth.currentUser?.photoURL ?? defaultIconPicture;

    UserEntity userEntity = userModel.toEntity();
    return Right(userEntity);

    } catch (e) {
      return const Left('An error occured');
    }
  }
}