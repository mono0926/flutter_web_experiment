import 'package:flutter/material.dart';
import 'package:mono_kit/mono_kit.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

import '../model/model.dart';
import '../model/stamp/stamps_ref.dart';

class ImageDetailPage extends StatelessWidget {
  const ImageDetailPage._({Key key}) : super(key: key);

  static Widget wrapped({@required String id}) {
    return ChangeNotifierProvider(
      builder: (context) {
        final notifier = Provider.of<StampsNotifier>(context, listen: false);
        final doc = notifier.docs.firstWhere(
          (doc) => doc.id == id,
          orElse: () => StampDoc(id, null),
        );
        return ImageDetailModel(doc: doc);
      },
      child: const ImageDetailPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ImageDetailModel>(context);
    final stamp = model.stamp;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(stamp?.name ?? ''),
      ),
      body: stamp == null
          ? null
          : PhotoView(
              imageProvider: Image.network(stamp.imageUrl).image,
            ),
    );
  }
}

class ImageDetailModel extends ChangeNotifier {
  ImageDetailModel({@required StampDoc doc}) {
    _doc = doc;
    _subscriptionHolder.add(
      StampsRef.ref().docRef(doc.id).document().listen((doc) {
        _doc = doc;
        notifyListeners();
      }),
    );
  }

  final _subscriptionHolder = SubscriptionHolder();
  StampDoc _doc;
  StampDoc get doc => _doc;
  Stamp get stamp => _doc?.entity;

  @override
  void dispose() {
    _subscriptionHolder.dispose();

    super.dispose();
  }
}
