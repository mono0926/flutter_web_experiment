import 'package:flutter/material.dart';
import 'package:flutter_web_experiment/model/model.dart';

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
      body: SizedBox.expand(
          child: Image.network(
        stamp.imageUrl,
        fit: BoxFit.contain,
      )),
    );
  }
}
