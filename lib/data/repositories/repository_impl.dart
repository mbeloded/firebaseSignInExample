
import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:single_sign_in_firestore/data/datasources/local_data_source.dart';
import 'package:single_sign_in_firestore/domain/entities/failure.dart';
import 'package:single_sign_in_firestore/domain/entities/user_entity.dart';
import 'package:single_sign_in_firestore/domain/repositories/repository.dart';

class RepositoryImpl implements Repository {

  LocalDataSource localDataSource;
  GoogleSignIn googleAuth = GoogleSignIn();

  RepositoryImpl({this.localDataSource});

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      return Right(await localDataSource.getCurrentUser());
    } on Error {
      return Left(CacheFailure());
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  Future<GoogleSignInAccount> authenticateWithGoogle() async {
    return googleAuth.signIn();
  }

  Future<GoogleSignInAccount> signOutGoogleAccount() async {
    return googleAuth.signOut();
  }

  Future<GoogleSignInAccount> disconnectGoogleAccount() async {
    return googleAuth.disconnect();
  }

}