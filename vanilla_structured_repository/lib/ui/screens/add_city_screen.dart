import 'package:flutter/material.dart';
import 'package:vanilla_structured_repository/data/app_state.dart';
import 'package:vanilla_structured_repository/model/city.dart';

class AddCityScreen extends StatefulWidget {
  final Function(String name) addCityName;
  final AppState appState;

  AddCityScreen({
    @required this.addCityName,
    this.appState,
  });

  @override
  _AddCityScreenState createState() => _AddCityScreenState();
}

class _AddCityScreenState extends State<AddCityScreen> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _cityName;

  List<City> _cities = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a new City"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
                key: formKey,
                autovalidate: false,
                child: TextFormField(
                  onChanged: (value) => onChangedText(value),
                  onSaved: (value) => _cityName = value,
                )),
            Expanded(
              child: ListView.builder(
                itemCount: _cities.length,
                itemBuilder: (context, index) {
                  final city = _cities[index];

                  return Card(
                    child: ListTile(
                      title: Text(city.name),
                      leading: IconButton(
                        icon: CircleAvatar(
                          child: Icon(Icons.add),
                        ),
                      ),
                      onTap: () => onTapItem(city.name),
                    ),
                    elevation: 10,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTapItem(String name) {
    widget.addCityName(name);
    Navigator.pop(context);
  }

  void onChangedText(String text) async {
    await widget.appState.api.getCities(text).then((value) {
      setState(() {
        _cities = value;
      });
    });
  }
}
