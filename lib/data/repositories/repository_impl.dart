
import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:single_sign_in_firestore/data/datasources/local_data_source.dart';
import 'package:single_sign_in_firestore/data/datasources/remote_data_source.dart';
import 'package:single_sign_in_firestore/domain/entities/failure.dart';
import 'package:single_sign_in_firestore/domain/entities/single_sign_in_resp.dart';
import 'package:single_sign_in_firestore/domain/entities/user_entity.dart';
import 'package:single_sign_in_firestore/domain/repositories/repository.dart';

class RepositoryImpl implements Repository {

  LocalDataSource localDataSource;
  RemoteDataSource remoteDataSource;
  GoogleSignIn googleAuth = GoogleSignIn();

  RepositoryImpl({this.localDataSource, this.remoteDataSource});

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

  Future<Either<Failure, SingleSignInDto>> googleSignIn(String token) async {

    try {
      //send token in request to FireStore and check the resp. in case user is there - return the userData obj
      var userResp = await remoteDataSource.googleSignIn(token);

      return Right(userResp);
    } catch (e) {
      print('Failure $e');
      return Left(e);
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