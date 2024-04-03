import 'package:cloud_firestore/cloud_firestore.dart';

class Contact {
  final String? name;
  final String? number;
  Contact({
    this.name,
    this.number,
  });

  factory Contact.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Contact(
      name: data?['name'],
      number: data?['number'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (number != null) "number": number,
    };
  }
}
