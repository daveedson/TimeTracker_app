import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:time_tracker_app_original/services/AuthController.dart';

//Generic user class
class User {
  final String uid;
  User({@required this.uid});
}

class Auth implements AuthController {
  final _firebaseAuth = FirebaseAuth.instance;

  /*
  Simply what the _userFromFirebase() method does is to convert  the FirebaseUser object,
  into a User Object which only contains the UID
   */

  //method to create any object of User from an Object of type FirebaseUser
  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid);
  }

  @override
  Stream<User> get onAuthStatChanged {
    return _firebaseAuth.onAuthStateChanged.map((_userFromFirebase));
  }

  //method for getting current User..
  @override
  Future<User> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  //method to Sign in  a user anonymously..
  @override
  Future<User> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  //method to signIn with google..
  @override
  Future<User> signInWithGoogle() async {
    //instance of googleSignIn class
    GoogleSignIn googleSignIn = new GoogleSignIn();

    //create google account,
    // *note*:this is the code that allows user sign in with a google account.
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    //this condition would be true if the user has completed the signIn condition successfully
    if (googleSignInAccount != null) {
      //code to get the access token
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      //call to firebase to get an auth result.
      if (googleSignInAuthentication.accessToken != null &&
          googleSignInAuthentication.idToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.getCredential(
              idToken: googleSignInAuthentication.idToken,
              accessToken: googleSignInAuthentication.accessToken),
        );

        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
          code: 'Error_Mising_google_auth_Token',
          message: 'Missing google auth Token',
        );
      }
    } else {
      throw PlatformException(
        code: 'Error_Aborted_by_User',
        message: 'Sign in aborted by user',
      );
    }
  }

  //this method LogsOut the current user
  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    return await _firebaseAuth.signOut();
  }
}
