// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ExerciseStruct extends FFFirebaseStruct {
  ExerciseStruct({
    DocumentReference? exerciseRefs,
    List<SetStruct>? sets,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _exerciseRefs = exerciseRefs,
        _sets = sets,
        super(firestoreUtilData);

  // "exerciseRefs" field.
  DocumentReference? _exerciseRefs;
  DocumentReference? get exerciseRefs => _exerciseRefs;
  set exerciseRefs(DocumentReference? val) => _exerciseRefs = val;

  bool hasExerciseRefs() => _exerciseRefs != null;

  // "sets" field.
  List<SetStruct>? _sets;
  List<SetStruct> get sets => _sets ?? const [];
  set sets(List<SetStruct>? val) => _sets = val;

  void updateSets(Function(List<SetStruct>) updateFn) {
    updateFn(_sets ??= []);
  }

  bool hasSets() => _sets != null;

  static ExerciseStruct fromMap(Map<String, dynamic> data) => ExerciseStruct(
        exerciseRefs: data['exerciseRefs'] as DocumentReference?,
        sets: getStructList(
          data['sets'],
          SetStruct.fromMap,
        ),
      );

  static ExerciseStruct? maybeFromMap(dynamic data) =>
      data is Map ? ExerciseStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'exerciseRefs': _exerciseRefs,
        'sets': _sets?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'exerciseRefs': serializeParam(
          _exerciseRefs,
          ParamType.DocumentReference,
        ),
        'sets': serializeParam(
          _sets,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static ExerciseStruct fromSerializableMap(Map<String, dynamic> data) =>
      ExerciseStruct(
        exerciseRefs: deserializeParam(
          data['exerciseRefs'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['exercises'],
        ),
        sets: deserializeStructParam<SetStruct>(
          data['sets'],
          ParamType.DataStruct,
          true,
          structBuilder: SetStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'ExerciseStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ExerciseStruct &&
        exerciseRefs == other.exerciseRefs &&
        listEquality.equals(sets, other.sets);
  }

  @override
  int get hashCode => const ListEquality().hash([exerciseRefs, sets]);
}

ExerciseStruct createExerciseStruct({
  DocumentReference? exerciseRefs,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ExerciseStruct(
      exerciseRefs: exerciseRefs,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ExerciseStruct? updateExerciseStruct(
  ExerciseStruct? exercise, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    exercise
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addExerciseStructData(
  Map<String, dynamic> firestoreData,
  ExerciseStruct? exercise,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (exercise == null) {
    return;
  }
  if (exercise.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && exercise.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final exerciseData = getExerciseFirestoreData(exercise, forFieldValue);
  final nestedData = exerciseData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = exercise.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getExerciseFirestoreData(
  ExerciseStruct? exercise, [
  bool forFieldValue = false,
]) {
  if (exercise == null) {
    return {};
  }
  final firestoreData = mapToFirestore(exercise.toMap());

  // Add any Firestore field values
  exercise.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getExerciseListFirestoreData(
  List<ExerciseStruct>? exercises,
) =>
    exercises?.map((e) => getExerciseFirestoreData(e, true)).toList() ?? [];
