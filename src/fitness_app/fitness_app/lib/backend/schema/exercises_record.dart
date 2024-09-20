import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ExercisesRecord extends FirestoreRecord {
  ExercisesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  bool hasCategory() => _category != null;

  // "body_part" field.
  String? _bodyPart;
  String get bodyPart => _bodyPart ?? '';
  bool hasBodyPart() => _bodyPart != null;

  // "calories" field.
  int? _calories;
  int get calories => _calories ?? 0;
  bool hasCalories() => _calories != null;

  // "rates" field.
  List<int>? _rates;
  List<int> get rates => _rates ?? const [];
  bool hasRates() => _rates != null;

  // "video" field.
  String? _video;
  String get video => _video ?? '';
  bool hasVideo() => _video != null;

  // "steps" field.
  List<String>? _steps;
  List<String> get steps => _steps ?? const [];
  bool hasSteps() => _steps != null;

  // "details" field.
  List<String>? _details;
  List<String> get details => _details ?? const [];
  bool hasDetails() => _details != null;

  // "comments_tips" field.
  List<String>? _commentsTips;
  List<String> get commentsTips => _commentsTips ?? const [];
  bool hasCommentsTips() => _commentsTips != null;

  // "comments" field.
  List<String>? _comments;
  List<String> get comments => _comments ?? const [];
  bool hasComments() => _comments != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _category = snapshotData['category'] as String?;
    _bodyPart = snapshotData['body_part'] as String?;
    _calories = castToType<int>(snapshotData['calories']);
    _rates = getDataList(snapshotData['rates']);
    _video = snapshotData['video'] as String?;
    _steps = getDataList(snapshotData['steps']);
    _details = getDataList(snapshotData['details']);
    _commentsTips = getDataList(snapshotData['comments_tips']);
    _comments = getDataList(snapshotData['comments']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('exercises');

  static Stream<ExercisesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ExercisesRecord.fromSnapshot(s));

  static Future<ExercisesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ExercisesRecord.fromSnapshot(s));

  static ExercisesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ExercisesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ExercisesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ExercisesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ExercisesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ExercisesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createExercisesRecordData({
  String? name,
  String? category,
  String? bodyPart,
  int? calories,
  String? video,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'category': category,
      'body_part': bodyPart,
      'calories': calories,
      'video': video,
    }.withoutNulls,
  );

  return firestoreData;
}

class ExercisesRecordDocumentEquality implements Equality<ExercisesRecord> {
  const ExercisesRecordDocumentEquality();

  @override
  bool equals(ExercisesRecord? e1, ExercisesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.name == e2?.name &&
        e1?.category == e2?.category &&
        e1?.bodyPart == e2?.bodyPart &&
        e1?.calories == e2?.calories &&
        listEquality.equals(e1?.rates, e2?.rates) &&
        e1?.video == e2?.video &&
        listEquality.equals(e1?.steps, e2?.steps) &&
        listEquality.equals(e1?.details, e2?.details) &&
        listEquality.equals(e1?.commentsTips, e2?.commentsTips) &&
        listEquality.equals(e1?.comments, e2?.comments);
  }

  @override
  int hash(ExercisesRecord? e) => const ListEquality().hash([
        e?.name,
        e?.category,
        e?.bodyPart,
        e?.calories,
        e?.rates,
        e?.video,
        e?.steps,
        e?.details,
        e?.commentsTips,
        e?.comments
      ]);

  @override
  bool isValidKey(Object? o) => o is ExercisesRecord;
}
