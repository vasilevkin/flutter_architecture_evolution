import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_weather/app/constants.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_signup_form/form_store.dart';

class FormExample extends StatefulWidget {
  const FormExample();

  @override
  _FormExampleState createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final FormStore store = FormStore();

  @override
  void initState() {
    super.initState();
    store.setupValidations();
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(Constants.exampleFormTitle),
        ),
        body: SingleChildScrollView(
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Observer(
                    builder: (_) => AnimatedOpacity(
                      opacity: store.isUserCheckPending ? 1 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: const LinearProgressIndicator(),
                    ),
                  ),
                  Observer(
                    builder: (_) => TextField(
                      decoration: InputDecoration(
                        labelText: Constants.exampleFormUsername,
                        hintText: Constants.exampleFormHintUsername,
                        errorText: store.error.username,
                      ),
                      onChanged: (value) => store.name = value,
                    ),
                  ),
                  Observer(
                    builder: (_) => TextField(
                      decoration: InputDecoration(
                        labelText: Constants.exampleFormEmail,
                        hintText: Constants.exampleFormHintEmail,
                        errorText: store.error.email,
                      ),
                      onChanged: (value) => store.email = value,
                    ),
                  ),
                  Observer(
                    builder: (_) => TextField(
                      decoration: InputDecoration(
                        labelText: Constants.exampleFormPassword,
                        hintText: Constants.exampleFormHintPassword,
                        errorText: store.error.password,
                      ),
                      onChanged: (value) => store.password = value,
                    ),
                  ),
                  Observer(
                    builder: (_) => TextField(
                      decoration: InputDecoration(
                        labelText: Constants.exampleFormPasswordConfirm,
                        hintText: Constants.exampleFormHintPasswordConfirm,
                        errorText: store.error.confirmPassword,
                      ),
                      onChanged: (value) => store.confirmPassword = value,
                    ),
                  ),
                  RaisedButton(
                    onPressed: store.validateAll,
                    child: const Text(Constants.exampleFormSignUp),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
