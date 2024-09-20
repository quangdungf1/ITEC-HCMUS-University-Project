import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class IssueRecord extends FirestoreRecord {
  IssueRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _description = snapshotData['description'] as String?;
    _image = snapshotData['image'] as String?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('issue')
          : FirebaseFirestore.instance.collectionGroup('issue');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('issue').doc(id);

  static Stream<IssueRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => IssueRecord.fromSnapshot(s));

  static Future<IssueRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => IssueRecord.fromSnapshot(s));

  static IssueRecord fromSnapshot(DocumentSnapshot snapshot) => IssueRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static IssueRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      IssueRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'IssueRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is IssueRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createIssueRecordData({
  String? title,
  String? description,
  String? image,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'description': description,
      'image': image,
    }.withoutNulls,
  );

  return firestoreData;
}

class IssueRecordDocumentEquality implements Equality<IssueRecord> {
  const IssueRecordDocumentEquality();

  @override
  bool equals(IssueRecord? e1, IssueRecord? e2) {
    return e1?.title == e2?.title &&
        e1?.description == e2?.description &&
        e1?.image == e2?.image;
  }

  @override
  int hash(IssueRecord? e) =>
      const ListEquality().hash([e?.title, e?.description, e?.image]);

  @override
  bool isValidKey(Object? o) => o is IssueRecord;
}
