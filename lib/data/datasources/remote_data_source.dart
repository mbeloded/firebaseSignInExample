
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:single_sign_in_firestore/domain/entities/failure.dart';
import 'package:single_sign_in_firestore/domain/entities/single_sign_in_resp.dart';

const USERS_COLLECTION = 'users';

abstract class RemoteDataSource {

  //check the user by id in firestore db
  Future<bool> checkIsUserPresent(String userId);

  //Sign Up
  Future<SingleSignInDto> createUser(SingleSignInDto userData);

  //Login
  Future<SingleSignInDto> getUser(String data);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final SharedPreferences sharedPreferences;
  CollectionReference personsCollection;

  RemoteDataSourceImpl(this.sharedPreferences) {
    this.personsCollection = FirebaseFirestore.instance.collection(USERS_COLLECTION);
  }

  @override
  Future<bool> checkIsUserPresent(String userId) async {
    final snap = await personsCollection.doc(userId).get();
    print('checked isPersonPresent ${snap.exists}');

    if (snap == null || !snap.exists) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<SingleSignInDto> createUser(SingleSignInDto userData) async {
    //save the user in firebase db
    final Map<String, dynamic> data = userData.profileInfo.toJson();

    personsCollection.doc(userData.token).set(data);

    return userData;

    // .catchError((
    //     Object error) {
    //   print(error);
    //   return Left(UserNotCreatedFailure(error));
    // });

    // return Right(userData);

  }

  @override
  Future<SingleSignInDto> getUser(String userId) async {

    final snap = await personsCollection.doc(userId).get();

    SingleSignInDto user = SingleSignInDto.fromJson(snap.data());

    return user;

  }

}