import 'package:firebase/firebase.dart';

import '../main.dart';

void configureFirestore() {
  _enablePersistence();
}

Stream<List<Stamp>> stampsStream() {
  return firestore().collection('stamps').onSnapshot.map(
      (snap) => snap.docs.map((snap) => Stamp.fromJson(snap.data())).toList());
}

Future _enablePersistence() async {
  try {
    await firestore().enablePersistence();
    // ignore: avoid_catches_without_on_clauses
  } catch (e) {
    print(e);
  }
}
