import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

import '../model/model.dart';
import '../model/stamp/stamps_ref.dart';
import '../platform/platform.dart';

class ImageDetailPage extends StatelessWidget {
  const ImageDetailPage._({Key key}) : super(key: key);

  static Widget wrapped({@required String id}) {
    return ChangeNotifierProxyProvider<StampsNotifier, ImageDetailModel>(
      builder: (context, notifier, previous) {
        final doc = notifier.docs.firstWhere(
          (doc) => doc.id == id,
          orElse: () => StampDoc(id, null),
        );
        return ImageDetailModel(
          doc: doc,
          docs: notifier.docs,
        );
      },
      child: const ImageDetailPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ImageDetailModel>(context);
    final stampsNotifier = Provider.of<StampsNotifier>(context);
    final docs = stampsNotifier.docs;

    return Scaffold(
      appBar: AppBar(
        title: Text(model.title),
      ),
      body: docs.isEmpty
          ? null
          : PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (context, index) {
                final doc = docs[index];
                return PhotoViewGalleryPageOptions(
                  imageProvider: Image.network(doc.entity.imageUrl).image,
                  initialScale: PhotoViewComputedScale.contained,
//                  minScale:
//                      PhotoViewComputedScale.contained * (0.5 + index / 10),
//                  maxScale: PhotoViewComputedScale.covered * 1.1,
                  heroAttributes: PhotoViewHeroAttributes(tag: doc.id),
                );
              },
              itemCount: docs.length,
//                loadingChild: widget.loadingChild,
              backgroundDecoration: BoxDecoration(color: Colors.white),
              pageController: model.pageController,
              onPageChanged: model.updateIndex,
            ),
    );
  }
}

class ImageDetailModel extends ChangeNotifier {
  ImageDetailModel({
    @required StampDoc doc,
    @required this.docs,
  }) : pageController = PageController(
          initialPage: docs.indexWhere((d) => d.id == doc.id),
        ) {
//    _updateDoc(doc);
    updateIndex(pageController.initialPage);
  }

  final PageController pageController;
  final List<StampDoc> docs;
  String _title = '';
//  StampDoc _doc;
  StampDoc get doc => docs.isEmpty ? null : docs[_index];
  Stamp get stamp => doc?.entity;
  String get title => _title;
  int _index = 0;

  void updateIndex(int index) {
    _index = index;
    if (doc == null) {
      return;
    }
    _title = '${stamp?.name ?? ''} (${_index + 1}/${docs.length})';
    notifyListeners();
    replaceUrlPath('#/${doc.id}');
  }
}
