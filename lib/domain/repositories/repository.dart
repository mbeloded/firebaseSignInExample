
import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:single_sign_in_firestore/domain/entities/failure.dart';
import 'package:single_sign_in_firestore/domain/entities/single_sign_in_resp.dart';
import 'package:single_sign_in_firestore/domain/entities/user_entity.dart';

abstract class Repository {

  ///User
  Future<Either<Failure, UserEntity>> getCurrentUser();
  Future<bool> checkIsUserPresent(String token);
  Future<Either<Failure, SingleSignInDto>> createUser(SingleSignInDto userData);

  Future<Either<Failure, SingleSignInDto>> googleSignIn(String token);
  Future<GoogleSignInAccount> authenticateWithGoogle();
  Future<GoogleSignInAccount> signOutGoogleAccount();
  Future<GoogleSignInAccount> disconnectGoogleAccount();

}
