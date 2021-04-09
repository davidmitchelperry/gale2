// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:instagram_repository/instagram_repository.dart';

class InstagramRepository {
  // [clientID], [appSecret], [redirectUri] from your facebook developer basic display panel.
  // [scope] choose what kind of data you're wishing to get.
  // [responseType] I recommend only 'code', I try on DEV MODE with token, it wasn't working.
  // [url] simply the url used to communicate with Instagram API at the beginning.
  static const String clientID = "860843208094582";
  static const String appSecret = "fd786307df2f5b28d725534f8cc90165";
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

  String? authorizationCode;
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

  Future<bool> getTokenAndUserID() async {
    var url = Uri.parse('https://api.instagram.com/oauth/access_token');

    /// Request token.
    /// Set token.
    /// Returning status request as bool.
    final response = await http.post(url, body: {
      'client_id': clientID,
      'redirect_uri': redirectUri,
      'client_secret': appSecret,
      'code': authorizationCode,
      'grant_type': 'authorization_code'
    });
    accessToken = json.decode(response.body)['access_token'].toString();
    userID = json.decode(response.body)['user_id'].toString();
    return (accessToken != null && userID != null) ? true : false;
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
