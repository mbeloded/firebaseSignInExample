
import 'package:google_sign_in/google_sign_in.dart';
import 'package:single_sign_in_firestore/domain/repositories/repository.dart';

class SignOutGoogleAccountUseCase {
  final Repository repository;

  SignOutGoogleAccountUseCase(this.repository);

  Future<GoogleSignInAccount> call() async {
    return repository.disconnectGoogleAccount();
  }
}