import 'package:google_sign_in/google_sign_in.dart';
import 'package:single_sign_in_firestore/domain/repositories/repository.dart';

class AuthenticateWithGoogleUseCase {
  final Repository repository;

  AuthenticateWithGoogleUseCase(this.repository);

  Future<GoogleSignInAccount> call() async {
    return repository.authenticateWithGoogle();
  }
}