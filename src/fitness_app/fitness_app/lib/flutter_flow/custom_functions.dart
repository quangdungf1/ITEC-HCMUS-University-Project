import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

List<SetStruct> createSets() {
  SetStruct set1 = SetStruct(reps: 0, weight: 0, number: 1);
  return <SetStruct>[set1];
}

List<String> getDays() {
  return <String>["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
}

List<int> getFrequency(List<DateTime> workouts) {
  List<int> frequency = List.filled(7, 0);

  for (var workout in workouts) {
    int dayOfWeek = workout.weekday;
    frequency[dayOfWeek - 1]++;
  }

  return frequency;
}

String? getRates(List<int> rates) {
  if (rates.isEmpty) return "0";
  int sum = rates.reduce((value, element) => value + element);
  return (sum / rates.length).toStringAsFixed(2).toString();
}

int countWorkOutInADay(List<DateTime> workouts) {
  DateTime targetDay = new DateTime.now();
  return workouts
      .where((workout) =>
          workout.year == targetDay.year &&
          workout.month == targetDay.month &&
          workout.day == targetDay.day)
      .length;
}

double? getCaloInfo(
  double weight,
  String gender,
  List<double> duration,
  List<DateTime> worksout,
  List<double> workout,
  double wishWeight,
  int timesToAchieve,
) {
  DateTime targetDay = new DateTime.now();
  double caloriesBurn = 0;
  double caloriesNeeded = (weight - wishWeight) * 3500 / (timesToAchieve * 31);
  double totalDuration = 0;

  //Calculate total duration from worksout in a day.
  for (int i = 0; i < worksout.length; i++) {
    if (worksout[i].year == targetDay.year &&
        worksout[i].month == targetDay.month &&
        worksout[i].day == targetDay.day) {
      totalDuration += duration[i];
    }
  }

  //Calculate calories that a male/female person needs to burn each day.
  totalDuration = totalDuration / 1000 / 60;
  if (gender == "Male") {
    caloriesBurn = 0.0713 * weight * totalDuration;
  } else
    caloriesBurn = 0.0637 * weight * totalDuration;

  return caloriesBurn / caloriesNeeded;
}

double? getCaloriesNeededToBurn(
  double userWeight,
  double wishWeight,
  int timesToAchieve,
) {
  double weightNeededToCut = userWeight - wishWeight;
  double result = double.parse(
      (weightNeededToCut * 3500 / (timesToAchieve * 30)).toStringAsFixed(2));
  return result;
}

double calCaloWithDur(
  String gender,
  double weight,
  double duration,
) {
  if (gender == "Male") {
    return double.parse(
        (0.0713 * weight * (duration / 1000 / 60)).toStringAsFixed(0));
  } else
    return double.parse(
        (0.0713 * weight * (duration / 1000 / 60)).toStringAsFixed(0));
}

double calCaloWithoutDur(
  List<DateTime> worksout,
  List<double> durations,
  double weight,
  String gender,
) {
  DateTime targetDay = new DateTime.now();
  double totalDuration = 0;
  for (int i = 0; i < worksout.length; i++) {
    if (worksout[i].year == targetDay.year &&
        worksout[i].month == targetDay.month &&
        worksout[i].day == targetDay.day) {
      totalDuration += durations[i];
    }
  }
  if (gender == "Male") {
    return double.parse(
        (0.0713 * weight * (totalDuration / 1000 / 60)).toStringAsFixed(0));
  } else
    return double.parse(
        (0.0637 * weight * (totalDuration / 1000 / 60)).toStringAsFixed(0));
}
