import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather/app/constants.dart';
import 'package:getx_weather/getx_example_auth_flow/features/features.dart';
import 'package:getx_weather/getx_example_auth_flow/models/models.dart';

class HomePage extends StatelessWidget {
  final User user;
  final _controller = Get.put(HomeController());

  HomePage({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.exampleAuthFlowHomePage),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              Text(
                '${Constants.exampleAuthFlowWelcome} ${user.name}',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 12),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                onPressed: () {
                  _controller.signOut();
                },
                child: Text(Constants.exampleAuthFlowLogout),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
