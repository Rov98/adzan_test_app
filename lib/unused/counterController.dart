import './counterModel.dart';
import 'package:get/get.dart';

class counterController extends GetxController {
  var counterModel = CounterModel(counter: 0).obs;
  var totalCounter = 0;

  void addIncrement() {
    counterModel.value.counter = counterModel.value.counter + 1;
    update(['joni', 'agus']);
  }
}
