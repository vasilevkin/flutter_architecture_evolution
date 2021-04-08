import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_weather/app/constants.dart';
import 'package:getx_weather/app/error_messages.dart';
import 'package:getx_weather/getx_example_auth_flow/features/authentication/authentication.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.exampleAuthFlowLogin),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: _SignInForm(),
      ),
    );
  }
}

class _SignInForm extends StatefulWidget {
  @override
  __SignInFormState createState() => __SignInFormState();
}

class __SignInFormState extends State<_SignInForm> {
  final _controller = Get.put(LoginController());

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Form(
        key: _key,
        autovalidateMode:
            _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: Constants.exampleAuthFlowEmail,
                  filled: true,
                  isDense: true,
                ),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                validator: (value) {
                  if (value == null) {
                    return ErrorMessages.exampleErrorAuthFlowEmailRequired;
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: Constants.exampleAuthFlowPassword,
                  filled: true,
                  isDense: true,
                ),
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (value == null) {
                    return ErrorMessages.exampleErrorAuthFlowPasswordRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                onPressed: _controller.state is LoginLoading
                    ? () {}
                    : _onLoginButtonPressed,
                child: Text(Constants.exampleAuthFlowLogin),
              ),
              const SizedBox(
                height: 20,
              ),
              if (_controller.state is LoginFailure)
                Text(
                  (_controller.state as LoginFailure).error,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Get.theme.errorColor,
                  ),
                ),
              if (_controller.state is LoginLoading)
                Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      );
    });
  }

  _onLoginButtonPressed() {
    if (_key.currentState.validate()) {
      _controller.login(_emailController.text, _passwordController.text);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
