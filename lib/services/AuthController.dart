import 'auth.dart';

//This class serves as an interface for holding all the auth methods..
abstract class AuthController {
  Future<User> currentUser();
  Future<User> signInAnonymously();
  Future<void> signOut();
  Stream<User> get onAuthStatChanged;
  Future<User> signInWithGoogle();
  Future<User> loginInWithFacebook();
  Future<User> signInWthEmailAndPassword(String email, password);
  Future<User> RegisterUserInWthEmailAndPassword(String email, password);
}
