import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';

export 'stamp_ref.dart';

class Stamp extends Entity {
  const Stamp({
    @required this.name,
    @required this.imageUrl,
  });

  Stamp.fromJson(Map<String, dynamic> json)
      : this(
          name: json[StampField.name] as String,
          imageUrl: json[StampField.imageUrl] as String,
        );

  final String name;
  final String imageUrl;
}

class StampField {
  static const name = 'name';
  static const imageUrl = 'imageUrl';
}
