import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

//enum MyZoomImageType { circle, rectangle }
//
//class MyZoomImage extends StatelessWidget {
//  final String imageUrl;
//  final double? radius;
//  final MyZoomImageType myZoomImageType;
//  final double elevation;
//
//  const MyZoomImage(
//      {required this.imageUrl,
//      this.radius,
//      this.myZoomImageType = MyZoomImageType.rectangle,
//      this.elevation = 8.0});
//
//  Future<void> _showImage(BuildContext context, ImageProvider provider) {
//    return showDialog(
//        context: context,
//        barrierDismissible: true,
//        builder: (ctx) {
//          return Container(
//            width: MediaQuery.of(context).size.width,
//            height: MediaQuery.of(context).size.height,
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              children: <Widget>[
//                Image(
//                  image: provider,
//                  fit: BoxFit.contain,
//                ),
//              ],
//            ),
//          );
//        });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    ImageProvider provider = CachedNetworkImageProvider(imageUrl);
//
//    switch (myZoomImageType) {
//      case MyZoomImageType.circle:
//        return InkWell(
//          child: CircleAvatar(
//            radius: radius,
//            backgroundImage: provider,
//          ),
//          onTap: () {
//            _showImage(context, provider);
//          },
//        );
//      case MyZoomImageType.rectangle:
//        return Material(
//          clipBehavior: Clip.antiAliasWithSaveLayer,
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.all(Radius.circular(radius?)),
//          ),
//          elevation: elevation,
//          child: InkWell(
//            child: Container(
//              child: Image(
//                image: provider,
//                fit: BoxFit.cover,
//              ),
//            ),
//            onTap: () {
//              _showImage(context, provider);
//            },
//          ),
//        );
//    }
//  }
//}
