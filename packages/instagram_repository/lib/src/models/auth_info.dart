class AuthInfoRequest {
  AuthInfoRequest(this.authorizationCode);
  final String authorizationCode;
}

class AuthInfoResponse {
  AuthInfoResponse(this.accessToken, this.userID);
  final String? accessToken;
  final String? userID;
}
