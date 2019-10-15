import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/model.dart';
import 'pages/home_page.dart';
import 'theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureFirestore();
  debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: buildTheme(),
      home: ChangeNotifierProvider(
        builder: (context) => StampsNotifier(),
        child: const HomePage(),
      ),
    );
  }
}
