import 'package:adzan_test_app/constant/constant.dart';
import 'package:adzan_test_app/model/alarm_model.dart';
import 'package:adzan_test_app/screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  //user widgetsFlutterbinding to glue the hive_flutter to flutter engine
  WidgetsFlutterBinding.ensureInitialized();
  //initialize hive for flutter using hive_Flutters Adapters
  await Hive.initFlutter();
  //register all adapter
  Hive.registerAdapter(AlarmAdapter());
  Hive.registerAdapter(TimeOfDayAdapter());
  //initialize openBox for creating the nosql DB
  await Hive.openBox(hiveBoxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter wiht local notification',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home_Page(),
    );
  }
}
