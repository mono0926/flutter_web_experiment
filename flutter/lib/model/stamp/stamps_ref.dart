import 'package:firestore_ref/firestore_ref.dart';

import 'stamp.dart';
import 'stamp_doc.dart';
import 'stamp_ref.dart';

export 'stamp_ref.dart';

class StampsRef extends CollectionRef<Stamp, StampDoc> {
  StampsRef.ref()
      : super(
          ref: firestoreInstance.collection(collection),
          decoder: _StampDocDecoder(),
          encoder: _StampEncoder(),
        );

  static const collection = 'stamps';

  @override
  StampRef docRef([String id]) {
    return StampRef(
      ref: docRefRaw(id),
      encoder: encoder,
      decoder: decoder,
    );
  }
}

class _StampDocDecoder extends DocumentDecoder<StampDoc> {
  @override
  StampDoc decode(DocumentSnapshot snapshot) {
    return StampDoc(
      snapshot.documentID,
      Stamp.fromJson(FirRefDocumentSnapshotEx(snapshot).data),
    );
  }
}

class _StampEncoder extends EntityEncoder<Stamp> {
  @override
  Map<String, dynamic> encode(Stamp entity) => <String, dynamic>{};
}
