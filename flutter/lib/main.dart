import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pinch_zoom_image/pinch_zoom_image.dart';

void main() {
  debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: _buildTheme(),
      home: const HomePage(),
    );
  }

  ThemeData _buildTheme() {
    final base = ThemeData.light();
    const fontFamily = 'Hiragino Maru Gothic ProN';
    return base.copyWith(
      primaryColor: Colors.pink,
      splashFactory: InkRipple.splashFactory,
      primaryTextTheme: base.primaryTextTheme.apply(
        fontFamily: fontFamily,
      ),
      accentTextTheme: base.accentTextTheme.apply(
        fontFamily: fontFamily,
      ),
      textTheme: base.textTheme.apply(
        fontFamily: fontFamily,
      ),
      cardTheme: base.cardTheme.copyWith(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ラヴさんスタンプ'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(8),
        crossAxisCount: 2,
        children: StampImage.all
            .map((url) => _GridCell(
                  imageUrl: url,
                ))
            .toList(),
      ),
    );
  }
}

class _GridCell extends StatelessWidget {
  const _GridCell({
    Key key,
    @required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Ink.image(
        fit: BoxFit.cover,
        image: Image.network(
          imageUrl,
        ).image,
        child: InkWell(
          onTap: () {},
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              constraints: const BoxConstraints.tightFor(
                width: double.infinity,
              ),
              color: Colors.black.withOpacity(0.5),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8,
                ),
                child: Text(
                  'Hello',
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.subhead.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StampImage {
  static const all = [
    'https://firebasestorage.googleapis.com/v0/b/flutter-web-experiment.appspot.com/o/stamps%2Fangry.png?alt=media&token=3826a963-fd4d-4ef3-b6a9-6c0a9fe2f2f8',
    'https://firebasestorage.googleapis.com/v0/b/flutter-web-experiment.appspot.com/o/stamps%2Fball_bring.png?alt=media&token=c81c0e87-1e8c-4b02-aee2-eddc9bb20820',
    'https://firebasestorage.googleapis.com/v0/b/flutter-web-experiment.appspot.com/o/stamps%2Fbath.png?alt=media&token=73957702-2f90-4b85-9f60-f7af6929f4cb',
    'https://firebasestorage.googleapis.com/v0/b/flutter-web-experiment.appspot.com/o/stamps%2Fbirthday.png?alt=media&token=06f8c464-a82f-4c10-b905-f18098d7fb55',
    'https://firebasestorage.googleapis.com/v0/b/flutter-web-experiment.appspot.com/o/stamps%2Fbye1.png?alt=media&token=cd9b8475-9e31-47ce-8554-97be9c0bc483',
  ];
}

class ImageDetailPage extends StatelessWidget {
  const ImageDetailPage({
    Key key,
    @required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PinchZoomImage(
        image: Image.network(imageUrl),
      ),
    );
  }
}
