import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_dartio/google_sign_in_dartio.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    return await auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    return await auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  userSignOutOfEmailAndPassword() async {
    await auth.signOut();
  }

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    await GoogleSignInDart.register(
      clientId:
          '571087772105-elbceijp4rd5bqjd093rafg5kjk7anqr.apps.googleusercontent.com',
    );
    return await GoogleSignIn().signIn();
  }

  userSignOutfromGoogle() async {
    await GoogleSignIn().signOut();
    await GoogleSignIn().disconnect();
  }
}
