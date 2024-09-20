import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class WorksoutRecord extends FirestoreRecord {
  WorksoutRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "timestamp" field.
  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  bool hasTimestamp() => _timestamp != null;

  // "exercises" field.
  List<ExerciseStruct>? _exercises;
  List<ExerciseStruct> get exercises => _exercises ?? const [];
  bool hasExercises() => _exercises != null;

  // "calories" field.
  double? _calories;
  double get calories => _calories ?? 0.0;
  bool hasCalories() => _calories != null;

  // "duration" field.
  double? _duration;
  double get duration => _duration ?? 0.0;
  bool hasDuration() => _duration != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _timestamp = snapshotData['timestamp'] as DateTime?;
    _exercises = getStructList(
      snapshotData['exercises'],
      ExerciseStruct.fromMap,
    );
    _calories = castToType<double>(snapshotData['calories']);
    _duration = castToType<double>(snapshotData['duration']);
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('worksout')
          : FirebaseFirestore.instance.collectionGroup('worksout');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('worksout').doc(id);

  static Stream<WorksoutRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => WorksoutRecord.fromSnapshot(s));

  static Future<WorksoutRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => WorksoutRecord.fromSnapshot(s));

  static WorksoutRecord fromSnapshot(DocumentSnapshot snapshot) =>
      WorksoutRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static WorksoutRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      WorksoutRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'WorksoutRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is WorksoutRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createWorksoutRecordData({
  String? name,
  DateTime? timestamp,
  double? calories,
  double? duration,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'timestamp': timestamp,
      'calories': calories,
      'duration': duration,
    }.withoutNulls,
  );

  return firestoreData;
}

class WorksoutRecordDocumentEquality implements Equality<WorksoutRecord> {
  const WorksoutRecordDocumentEquality();

  @override
  bool equals(WorksoutRecord? e1, WorksoutRecord? e2) {
    const listEquality = ListEquality();
    return e1?.name == e2?.name &&
        e1?.timestamp == e2?.timestamp &&
        listEquality.equals(e1?.exercises, e2?.exercises) &&
        e1?.calories == e2?.calories &&
        e1?.duration == e2?.duration;
  }

  @override
  int hash(WorksoutRecord? e) => const ListEquality()
      .hash([e?.name, e?.timestamp, e?.exercises, e?.calories, e?.duration]);

  @override
  bool isValidKey(Object? o) => o is WorksoutRecord;
}
