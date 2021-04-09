import 'package:meta/meta.dart';

class InstaMedia {
  String? id, type, url, username, timestamp;
  bool? selected;

  InstaMedia(Map<String, dynamic> m) {
    id = m['id'].toString();
    type = m['media_type'].toString();
    url = m['media_url'].toString();
    username = m['username'].toString();
    timestamp = m['timestamp'].toString();
    selected = false;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "keyID": id,
      "keyType": type,
      "keyURL": url,
      "keyUsername": username,
      "keyTimestamp": DateTime.now(),
    };
  }
}
