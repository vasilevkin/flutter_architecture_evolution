import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather/app/constants.dart';
import 'package:getx_weather/getx_example_login_api/controller/home_api_controller.dart';
import 'package:getx_weather/getx_example_login_api/controller/login_api_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatelessWidget {
  final LoginApiController _loginController = Get.find();
  final HomeApiController _homeController = Get.put(HomeApiController());

  @override
  Widget build(BuildContext context) {
    print(
        '${Constants.exampleApiLoginTitle}::_loginController.emailTextController?.text:: ${_loginController.emailTextController?.text}');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(Constants.exampleApiLoginDashboard),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '${Constants.exampleAuthFlowWelcome} ${_loginController.emailTextController?.text}',
              style: GoogleFonts.exo2(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemBuilder: (context, index) => ListTile(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
