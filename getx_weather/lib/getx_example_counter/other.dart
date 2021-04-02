import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather/getx_example_counter/controller.dart';

class Other extends StatelessWidget {
  final Controller c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('${c.count}'),
      ),
    );
  }
}
