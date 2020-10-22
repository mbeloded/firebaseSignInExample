
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:single_sign_in_firestore/domain/entities/single_sign_in_resp.dart';

abstract class RemoteDataSource {

  //Sign Up
  Future<SingleSignInDto> singleSignUp(SingleSignInDto data);

  //Login
  Future<SingleSignInDto> googleSignIn(String data);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final SharedPreferences sharedPreferences;
  final Query query = FirebaseFirestore.instance.collection('users');

  RemoteDataSourceImpl(this.sharedPreferences);

  @override
  Future<SingleSignInDto> singleSignUp(SingleSignInDto data) async {

    // var body = json.encode(data);
    // print(body);
    // var resp = await client.post("auth/register", body, withAuthorization: data.wasGuestUser);
    // return SingleSignUpResponse.fromJson(resp);
  }

  @override
  Future<SingleSignInDto> googleSignIn(String data) async {

    var resp = await query.get().then((querySnapshot) async {
      return querySnapshot.docs.firstWhere((document) => document.toString() == data);
    });

    print("resp: $resp");
    return SingleSignInDto();
    // var body = json.encode(data);
    // print(body);
    // var resp = await client.post("auth/google", body);
    // return SingleSignInResponse.fromJson(resp);
  }

}