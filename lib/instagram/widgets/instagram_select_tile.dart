import 'package:instagram_repository/instagram_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/instagram/instagram.dart';

//class InstagramSelectTile extends StatelessWidget {
//  final InstaMedia media;
//  final Function onChanged;
//
//  const InstagramSelectTile({
//    Key key,
//    @required this.media,
//    this.onChanged,
//  }) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: const EdgeInsets.all(8.0),
//      child: Stack(
//        children: [
//          MyZoomImage(
//            imageUrl: media.url,
//            radius: 15,
//          ),
//          Positioned(
//              bottom: 0,
//              right: 0,
//              child: Checkbox(
//                  value: media.selected,
//                  onChanged: (bool status) {
//                    onChanged();
//                  }))
//        ],
//      ),
//    );
//  }
//}
