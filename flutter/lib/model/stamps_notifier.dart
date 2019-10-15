import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_web_experiment/model/stamp/stamp_doc.dart';
import 'package:flutter_web_experiment/model/stamp/stamps_ref.dart';
import 'package:mono_kit/mono_kit.dart';

import 'stamp/stamp.dart';

class StampsNotifier extends ChangeNotifier {
  StampsNotifier() {
    _load();
  }

  final _subscriptionHolder = SubscriptionHolder();

  Future _load() async {
    _subscriptionHolder.add(
      StampsRef.ref().documents((r) => r).listen((stamps) {
        _docs = stamps;
        notifyListeners();
      }),
    );
  }

  var _docs = <StampDoc>[];
  List<Stamp> get stamps => UnmodifiableListView(_docs.map((d) => d.entity));

  @override
  void dispose() {
    _subscriptionHolder.dispose();

    super.dispose();
  }
}
