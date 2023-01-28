import 'package:adzan_test_app/constant/constant.dart';
import 'package:adzan_test_app/model/alarm_model.dart';
import 'package:adzan_test_app/services/notification_services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class Alarm_Controller extends GetxController {
  List<Alarm> _listAlarm = [];

  final _boxAlarm = Hive.box(hiveBoxName);
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final notificationController = Get.put(Notification_Service());

  List<Alarm> get allAlarm {
    // print(_boxAlarm.keys.map<Alarm>((e) => _boxAlarm.get(e)).toList());
    return [..._listAlarm];
  }

  //initState using getX
  @override
  void onInit() {
    super.onInit();
    //fetch data
    fetchData();
    //initialize notification for the whole controller.
    Notification_Service.initialize(_flutterLocalNotificationsPlugin);
  }

  Future<void> addAlarm(String title, TimeOfDay timePicked) async {
    final newAlarm = Alarm(
        title: title, dateTime: timePicked, description: '', isActive: true);
    _listAlarm.add(newAlarm);
    await _boxAlarm.add(newAlarm);
    update();
    if (kDebugMode) {
      print('New Alarm Created at ${_boxAlarm.keys.last}');
    }
    Get.find<Notification_Service>().showScheduleNotification(
        title: title,
        body: 'body of notification',
        timeOfDay: newAlarm.dateTime!);
  }

  void fetchData() {
    final newAlarm =
        _boxAlarm.keys.map<Alarm>((e) => _boxAlarm.get(e)).toList();
    if (newAlarm.isEmpty) {
      _listAlarm = [];
    } else {
      _listAlarm = newAlarm;
    }
    update();
  }

  void deleteItem(int index) {
    _listAlarm.removeAt(index);
    _boxAlarm.deleteAt(index);
    update();
    if (kDebugMode) {
      print('deleted at $index');
    }
  }
}
