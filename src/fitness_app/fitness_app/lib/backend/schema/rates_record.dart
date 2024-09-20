import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RatesRecord extends FirestoreRecord {
  RatesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "comments" field.
  String? _comments;
  String get comments => _comments ?? '';
  bool hasComments() => _comments != null;

  // "users" field.
  DocumentReference? _users;
  DocumentReference? get users => _users;
  bool hasUsers() => _users != null;

  // "point" field.
  String? _point;
  String get point => _point ?? '';
  bool hasPoint() => _point != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _comments = snapshotData['comments'] as String?;
    _users = snapshotData['users'] as DocumentReference?;
    _point = snapshotData['point'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('rates')
          : FirebaseFirestore.instance.collectionGroup('rates');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('rates').doc(id);

  static Stream<RatesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => RatesRecord.fromSnapshot(s));

  static Future<RatesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => RatesRecord.fromSnapshot(s));

  static RatesRecord fromSnapshot(DocumentSnapshot snapshot) => RatesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static RatesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      RatesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'RatesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is RatesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createRatesRecordData({
  String? comments,
  DocumentReference? users,
  String? point,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'comments': comments,
      'users': users,
      'point': point,
    }.withoutNulls,
  );

  return firestoreData;
}

class RatesRecordDocumentEquality implements Equality<RatesRecord> {
  const RatesRecordDocumentEquality();

  @override
  bool equals(RatesRecord? e1, RatesRecord? e2) {
    return e1?.comments == e2?.comments &&
        e1?.users == e2?.users &&
        e1?.point == e2?.point;
  }

  @override
  int hash(RatesRecord? e) =>
      const ListEquality().hash([e?.comments, e?.users, e?.point]);

  @override
  bool isValidKey(Object? o) => o is RatesRecord;
}
