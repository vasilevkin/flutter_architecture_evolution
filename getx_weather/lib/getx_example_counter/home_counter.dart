import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather/app/constants.dart';
import 'package:getx_weather/getx_example_counter/controller.dart';
import 'package:getx_weather/getx_example_counter/other.dart';

class HomeCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text('${Constants.exampleCounterClicks} ${c.count}'),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Get.to(Other()),
          child: Text(Constants.exampleCounterOther),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: c.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}
