import 'dart:collection';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_experiment/firestore/web.dart';
import 'package:mono_kit/mono_kit.dart';
import 'package:provider/provider.dart';

void main() {
//  try {
//    initializeApp(
//      apiKey: 'AIzaSyAtY9niKr3OHnJ38roJy0HdV2QzXPm894Y',
//      authDomain: 'flutter-web-experiment.firebaseapp.com',
//      databaseURL: 'https://flutter-web-experiment.firebaseio.com',
//      storageBucket: 'flutter-web-experiment.appspot.com',
//      projectId: 'flutter-web-experiment',
//      messagingSenderId: '687526962423',
//    );
//  } on FirebaseJsNotLoadedException catch (e) {
//    print(e);
//  }

  configureFirestore();

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
      home: ChangeNotifierProvider(
        builder: (context) => StampsNotifier(),
        child: const HomePage(),
      ),
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
    final notifier = Provider.of<StampsNotifier>(context);
    final stamps = notifier.stamps;
    return Scaffold(
      appBar: AppBar(
        title: const Text('ラヴさんスタンプ'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () async {},
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: min(5, constraints.maxWidth ~/ 150),
          ),
          itemBuilder: (context, index) => _GridCell(stamp: stamps[index]),
          itemCount: stamps.length,
        ),
      ),
    );
  }
}

class _GridCell extends StatelessWidget {
  const _GridCell({
    Key key,
    @required this.stamp,
  }) : super(key: key);

  final Stamp stamp;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Ink.image(
        fit: BoxFit.cover,
        image: Image.network(
          stamp.imageUrl,
        ).image,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push<void>(
              MaterialPageRoute(
                builder: (context) => ImageDetailPage(stamp: stamp),
                settings: RouteSettings(name: stamp.name),
              ),
            );
          },
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
                  stamp.name,
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

class DisableBackSwipe extends StatelessWidget {
  const DisableBackSwipe({
    Key key,
    @required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>
          Future.value(!Navigator.of(context).userGestureInProgress),
      child: child,
    );
  }
}

@immutable
class Stamp {
  const Stamp({
    @required this.name,
    @required this.imageUrl,
  });

  Stamp.fromJson(Map<String, dynamic> json)
      : this(
          name: json['name'] as String,
          imageUrl: json['imageUrl'] as String,
        );

  final String name;
  final String imageUrl;
}

class StampsNotifier extends ChangeNotifier {
  StampsNotifier() {
    _load();
  }

  final _subscriptionHolder = SubscriptionHolder();

  Future _load() async {
    _subscriptionHolder.add(
      stampsStream().listen((stamps) {
        _stamps = stamps;
        notifyListeners();
      }),
    );
  }

  var _stamps = <Stamp>[];
  List<Stamp> get stamps => UnmodifiableListView(_stamps);

  @override
  void dispose() {
    _subscriptionHolder.dispose();

    super.dispose();
  }
}
