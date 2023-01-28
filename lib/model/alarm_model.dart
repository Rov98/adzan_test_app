import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

//generate an adapter with hive_generator and build_runner
part 'alarm_model.g.dart';

@HiveType(typeId: 0)
class Alarm extends HiveObject {
  @HiveField(0)
  String? title;
  @HiveField(1)
  String? description;
  @HiveField(2)
  TimeOfDay? dateTime;
  @HiveField(3)
  bool? isActive;

  Alarm({this.title, this.description, this.dateTime, this.isActive});
}
