import '../constant/constant.dart';
import '../controller/alarm_controller.dart';
import '../widget/appbar_Default.dart';
import '../widget/listtile_cover.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'package:get/get.dart';

class Home_Page extends StatelessWidget {
  Home_Page({super.key});

  final timePicked = TimeOfDay.now().obs;
  final titleController = TextEditingController();
  final temptVal = list_adzanName.first.obs;
  var customTextTheme = Apptheme().dataTheme;

  //function to show an alarm dialog creation
  void showAddAlarm(context) {
    Get.dialog(
      AlertDialog(
        title: const Text(
          'Add Alarm',
          style: TextStyle(fontSize: 20),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Obx(() => DropdownButton(
                    items: list_adzanName.map((String e) {
                      return DropdownMenuItem(value: e, child: Text(e));
                    }).toList(),
                    value: temptVal.value,
                    onChanged: (value) {
                      print(value);
                      temptVal.value = value!;
                    },
                  )),
            ),
            ElevatedButton(
              onPressed: () async {
                final result = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  builder: (context, childWidget) => MediaQuery(
                      data: MediaQuery.of(context)
                          .copyWith(alwaysUse24HourFormat: true),
                      child: childWidget!),
                );
                if (result == null) {
                  return;
                }
                timePicked.value = result;
              },
              child: Obx(() => Text(
                    '${timePicked.value.hour}:${timePicked.value.minute}',
                    style: const TextStyle(fontSize: 20),
                  )),
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('close'),
          ),
          TextButton(
              onPressed: () {
                Get.find<Alarm_Controller>()
                    .addAlarm(temptVal.value, timePicked.value);
                Get.back();
              },
              child: const Text('Add Alarm'))
        ],
      ),
      useSafeArea: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar_default(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            GetBuilder<Alarm_Controller>(
              init: Alarm_Controller(),
              initState: (_) {},
              builder: (controller) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.allAlarm.length,
                    itemBuilder: (context, index) => ListTile_Cover(
                      child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                controller.allAlarm[index].title.toString(),
                                style: customTextTheme.textTheme.bodySmall,
                              ),
                              Text(
                                '${controller.allAlarm[index].dateTime!.hour}:${controller.allAlarm[index].dateTime!.minute}',
                                style: customTextTheme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              Get.find<Alarm_Controller>().deleteItem(index);
                            },
                            icon: const Icon(Icons.delete_outlined, color: Colors.black, size: 30),
                          )),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddAlarm(context),
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
