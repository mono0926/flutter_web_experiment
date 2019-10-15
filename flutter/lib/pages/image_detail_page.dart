import 'package:flutter/material.dart';
import 'package:flutter_web_experiment/model/model.dart';
import 'package:photo_view/photo_view.dart';

class ImageDetailPage extends StatelessWidget {
  const ImageDetailPage({
    Key key,
    @required this.stamp,
  }) : super(key: key);

  final Stamp stamp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PhotoView(
        imageProvider: Image.network(
          stamp.imageUrl,
          fit: BoxFit.contain,
        ).image,
      ),
    );
  }
}
