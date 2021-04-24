// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:instagram_repository/instagram_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class InstagramRepository {
  InstagramRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;
  final firebase_auth.FirebaseAuth _firebaseAuth;
  // [clientID], [redirectUri] from your facebook developer basic display panel.
  // [scope] choose what kind of data you're wishing to get.
  // [url] simply the url used to communicate with Instagram API at the beginning.
  static const String clientID = "860843208094582";
  static const String redirectUri = 'https://www.davidmitchelperry.com/auth/';
  static const String scope = 'user_profile,user_media';
  static const String responseType = 'code';
  static const String url =
      'https://api.instagram.com/oauth/authorize?client_id=${clientID}&redirect_uri=${redirectUri}&scope=${scope}&response_type=${responseType}';
  // Presets your required fields on each call api.
  // Please refers to https://developers.facebook.com/docs/instagram-basic-display-api/reference .
  List<String> userFields = ['id', 'username'];
  List<String> mediasListFields = ['id', 'caption'];
  List<String> mediaFields = [
    'id',
    'media_type',
    'media_url',
    'username',
    'timestamp'
  ];
  Duration tokenLife = const Duration(
    hours: 1,
  );

  String? authorizationCode;
  DateTime? accessTokenExpirationTime; // Assumes tokens last for tokenLife
  String? accessToken;
  String? userID;
  Map<String, String>? instaProfile;
  List<InstaMedia>? medias;

  // TODO: int get/set authorizationCode
  void setAuthorizationCode(String url) {
    /// Parsing the code from string url.
    authorizationCode =
        url.replaceAll('${redirectUri}?code=', '').replaceAll('#_', '');
  }

  Future<AuthInfoResponse> _getAuthInfo() async {
    String? accessToken, userID;
    await _firebaseAuth.currentUser?.getIdToken().then((idToken) async {
      var headers = {'Authorization': 'Bearer ' + idToken};
      print("INSTAGRAM LOG");
      print(Uri.parse('http://192.168.1.190:8080/firebase/'));
      final response = await http.post(
        //Uri.parse('https://gale-648cf.uc.r.appspot.com/firebase/'),
        Uri.parse('http://192.168.1.190:8080/firebase/'),
        headers: headers,
        body: {'authorizationCode': authorizationCode},
      );
      print("INSTAGRAM LOG:");
      print(response.body);
      dynamic payload = json.decode(response.body);
      accessToken = payload['access_token'].toString();
      userID = payload['user_id'].toString();
    });
    return AuthInfoResponse(accessToken, userID);
  }

  Future<bool> getTokenAndUserID() async {
    var response = await _getAuthInfo();
    accessToken = response.accessToken;
    userID = response.userID;
    if (accessToken != null && userID != null) {
      accessTokenExpirationTime = DateTime.now().add(
        tokenLife,
      );
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getUserProfile() async {
    /// Parse according fieldsList.
    /// Request instagram user profile.
    /// Set profile.
    /// Returning status request as bool.
    final fields = userFields.join(',');
    final responseNode = await http.get(Uri.parse(
        'https://graph.instagram.com/$userID?fields=$fields&access_token=$accessToken'));
    instaProfile = {
      'id': json.decode(responseNode.body)['id'].toString(),
      'username': json.decode(responseNode.body)['username'].toString(),
    };
    return (instaProfile != null) ? true : false;
  }

  Future<List<InstaMedia>> getAllMedias() async {
    /// Parse according fieldsList.
    /// Request instagram user medias list.
    /// Request for each media id the details.
    /// Set all medias as list Object.
    /// Returning the List<InstaMedia>.
    final fields = mediasListFields.join(',');
    final responseMedia = await http.get(Uri.parse(
        'https://graph.instagram.com/$userID/media?fields=$fields&access_token=$accessToken'));
    final dynamic mediasList = json.decode(responseMedia.body);
    List<InstaMedia> medias = [];
    for (var media in mediasList['data']) {
      dynamic m = await getMediaDetails(media['id'] as String);
      InstaMedia instaMedia = InstaMedia(m as Map<String, dynamic>);
      medias.add(instaMedia);
    }
    return medias;
  }

  Future<Map<String, dynamic>> getMediaDetails(String? mediaID) async {
    /// Parse according fieldsList.
    /// Request complete media informations.
    /// Returning the response as Map<String, dynamic>
    final fields = mediaFields.join(',');
    final responseMediaSingle = await http.get(Uri.parse(
        'https://graph.instagram.com/$mediaID?fields=$fields&access_token=$accessToken'));
    return json.decode(responseMediaSingle.body) as Map<String, dynamic>;
  }

  String helloWorld() {
    return "helloWorld";
  }
}
