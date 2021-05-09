import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather/app/constants.dart';
import 'package:getx_weather/app/error_messages.dart';
import 'package:getx_weather/getx_example_login_api/controller/login_api_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatelessWidget {
  final LoginApiController _loginApiController = Get.put(LoginApiController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(Constants.exampleApiLoginTitle)),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _loginApiController.emailTextController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: Colors.grey[200],
                  filled: true,
                  hintText: Constants.exampleAuthFlowEmail,
                  hintStyle: GoogleFonts.exo2(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                ),
                style: GoogleFonts.exo2(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                validator: (value) => value.trim().isEmpty
                    ? ErrorMessages.exampleErrorAuthFlowEmailRequired
                    : null,
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _loginApiController.emailTextController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  fillColor: Colors.grey[200],
                  filled: true,
                  hintText: Constants.exampleAuthFlowPassword,
                  hintStyle: GoogleFonts.exo2(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                ),
                style: GoogleFonts.exo2(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                validator: (value) => value.trim().isEmpty
                    ? ErrorMessages.exampleErrorAuthFlowPasswordRequired
                    : null,
              ),
              SizedBox(height: 16),
              MaterialButton(
                color: Colors.deepOrangeAccent,
                splashColor: Colors.white,
                height: 45,
                minWidth: Get.width / 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _loginApiController.apiLogin();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
