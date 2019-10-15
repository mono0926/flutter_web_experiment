import 'package:firestore_ref/firestore_ref.dart';
import 'package:meta/meta.dart';

import 'stamp.dart';
import 'stamp_doc.dart';

export 'stamp_doc.dart';

class StampRef extends DocumentRef<Stamp, StampDoc> {
  const StampRef({
    @required DocumentReference ref,
    @required DocumentDecoder<StampDoc> decoder,
    @required EntityEncoder<Stamp> encoder,
  }) : super(
          ref: ref,
          decoder: decoder,
          encoder: encoder,
        );
}
