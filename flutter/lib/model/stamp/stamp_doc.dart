import 'package:firestore_ref/firestore_ref.dart';

import 'stamp.dart';

class StampDoc extends Document<Stamp> {
  const StampDoc(
    String id,
    Stamp entity,
  ) : super(
          id,
          entity,
        );
}
