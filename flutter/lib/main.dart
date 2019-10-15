import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mono_kit/mono_kit.dart';
import 'package:provider/provider.dart';

import 'model/model.dart';
import 'pages/home_page.dart';
import 'pages/image_detail_page.dart';
import 'theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureFirestore();
  debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  runApp(
    ChangeNotifierProvider(
      builder: (context) => StampsNotifier(),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: buildTheme(),
//      initialRoute: '/angry',
      home: const HomePage(),
      onGenerateRoute: (settings) {
        final name = settings.name;
        return FadePageRoute<void>(
          builder: (context) => ImageDetailPage.wrapped(id: name.split('/')[1]),
          settings: settings,
        );
      },
    );
  }
}
