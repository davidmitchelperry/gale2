import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:oauth1/oauth1.dart';

import 'models/models.dart';

/// Thrown if during the sign up process if a failure occurs.
class SignUpFailure implements Exception {}

/// Thrown during the login process if a failure occurs.
class LogInWithEmailAndPasswordFailure implements Exception {}

/// Thrown during the sign in with google process if a failure occurs.
class LogInWithGoogleFailure implements Exception {}

class LogInWithTwitterFailure implements Exception {}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

class AuthenticationRepository {
  // TODO: These probably shouldnt be nullable
  AuthenticationRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  // Twitter Credential Information
  final String _twitterConsumerKey = "e7HMFxGoC0Zbl2qsdp3O2s5SB";
  final String _twitterConsumerSecret =
      "U6BJiEollMvtctdxkpHLMuUT14ZjhaJedD7ejRtH3lpe6UndWH";
  final String _oauthCallBackHandler = "https://davidmitchelperry.com/auth/";

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null ? User.empty : firebaseUser.toUser;
    });
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpFailure] if an exception occurs.
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    assert(email != null && password != null);
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception {
      throw SignUpFailure();
    }
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  Future<void> logInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on Exception {
      throw LogInWithGoogleFailure();
    }
  }

  Future<void> logInWithTwitter(String oauthtoken, String oauthverifier) async {
    try {
      print("in logInWithTwitter from repo");
      final _twitterClientCredentials =
          ClientCredentials(_twitterConsumerKey, _twitterConsumerSecret);

      final twitterPlatform = Platform(
        'https://api.twitter.com/oauth/request_token', // temporary credentials request
        'https://api.twitter.com/oauth/authorize', // resource owner authorization
        'https://api.twitter.com/oauth/access_token', // token credentials request
        SignatureMethods.hmacSha1, // signature method
      );

      var _oauth = Authorization(_twitterClientCredentials, twitterPlatform);
      // Step 3 - Request Access Token
      var tokenCredentialsResponse = await _oauth.requestTokenCredentials(
          Credentials(oauthtoken, ''), oauthverifier);
      //firebase_auth.TwitterAuthProvider.
      final firebase_auth.AuthCredential result =
          firebase_auth.TwitterAuthProvider.credential(
        accessToken: tokenCredentialsResponse.credentials.token,
        secret: tokenCredentialsResponse.credentials.tokenSecret,
      );
      //var result = TwitterAuthProvider.getCredential(
      //  authToken: tokenCredentialsResponse.credentials.token,
      //  authTokenSecret: tokenCredentialsResponse.credentials.tokenSecret,
      //);

      //final credential = firebase_auth.GoogleAuthProvider.credential(
      //  accessToken: oauthtoken,
      //  idToken: oauthverifier,
      //);
      await _firebaseAuth.signInWithCredential(result);
    } on Exception {
      throw LogInWithTwitterFailure();
    }
  }

  Future<String?> getTwitterAuthorizationPage() async {
    final _twitterClientCredentials =
        ClientCredentials(_twitterConsumerKey, _twitterConsumerSecret);

    final twitterPlatform = Platform(
      'https://api.twitter.com/oauth/request_token', // temporary credentials request
      'https://api.twitter.com/oauth/authorize', // resource owner authorization
      'https://api.twitter.com/oauth/access_token', // token credentials request
      SignatureMethods.hmacSha1, // signature method
    );

    var _oauth = Authorization(_twitterClientCredentials, twitterPlatform);

    // Step 1 - Request Token
    final requestTokenResponse =
        await _oauth?.requestTemporaryCredentials(_oauthCallBackHandler);
    // Step 2 - Redirect to Authorization Page
    var authorizationPage = _oauth?.getResourceOwnerAuthorizationURI(
        requestTokenResponse!.credentials.token);

    return authorizationPage;
  }

  // Create a TwitterLogin instance
  //final TwitterLogin twitterLogin = new TwitterLogin(
  //  consumerKey: 'e7HMFxGoC0Zbl2qsdp3O2s5SB',
  //  consumerSecret: 'U6BJiEollMvtctdxkpHLMuUT14ZjhaJedD7ejRtH3lpe6UndWH',
  //);

  //try {
  //  // Trigger the sign-in flow
  //  final TwitterLoginResult loginResult = await twitterLogin.authorize();
  //  // Get the Logged In session
  //  final TwitterSession twitterSession = loginResult.session;
  //  // Create a credential from the access token
  //  final firebase_auth.AuthCredential twitterAuthCredential =
  //      firebase_auth.TwitterAuthProvider.credential(
  //          accessToken: twitterSession.token, secret: twitterSession.secret);
  //  // Once signed in, return the UserCredential
  //  await _firebaseAuth.signInWithCredential(twitterAuthCredential);
  //} on Exception {}

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    assert(email != null && password != null);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } on Exception {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(
        id: uid, email: email ?? "", name: displayName, photo: photoURL);
  }
}
