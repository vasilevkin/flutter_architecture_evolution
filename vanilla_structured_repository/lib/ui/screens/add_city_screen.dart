import 'package:flutter/material.dart';

class AddCityScreen extends StatefulWidget {
  final Function(String name) addCityName;

  AddCityScreen({
    @required this.addCityName,
  });

  @override
  _AddCityScreenState createState() => _AddCityScreenState();
}

class _AddCityScreenState extends State<AddCityScreen> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a new City"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
            key: formKey,
            autovalidate: false,
            child: ListView(
              children: [
                TextFormField(
                  onSaved: (value) => _cityName = value,
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            final form = formKey.currentState;
            if (form.validate()) {
              form.save();

              final cityName = _cityName;

              widget.addCityName(cityName);
              Navigator.pop(context);
            }
          }),
    );
  }
}
