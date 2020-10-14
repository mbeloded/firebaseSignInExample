import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:single_sign_in_firestore/domain/entities/user_entity.dart';

abstract class LocalDataSource {

  Future<UserEntity> getCurrentUser();
  Future<bool> saveCurrentUser(UserEntity user);
  Future<bool> clearCurrentUser();

}

const KEY_USER = 'USER';
const KEY_USER_ID = 'USER_ID';

class LocalDataSourceImpl implements LocalDataSource {
  SharedPreferences sharedPreferences;

  LocalDataSourceImpl([this.sharedPreferences]);

  @override
  Future<UserEntity> getCurrentUser() {

    var userEntity = UserEntity.fromJson(json.decode(sharedPreferences.getString(KEY_USER)));
    var completer = new Completer<UserEntity>();

    completer.complete(userEntity);

    return completer.future;

  }

  @override
  Future<bool> saveCurrentUser(UserEntity user) async {
    var jsonString = user.toJson().toString();
    return sharedPreferences.setString(KEY_USER, jsonString);
  }

  @override
  Future<bool> clearCurrentUser() async {

    final result = await sharedPreferences.setString(KEY_USER, null);
    return result;

  }
}