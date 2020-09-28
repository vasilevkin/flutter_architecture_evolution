import 'package:flutter/material.dart';
import 'package:vanilla_structured_repository/data/app_state.dart';
import 'package:vanilla_structured_repository/model/city.dart';
import 'package:vanilla_structured_repository/ui/widgets/add_city_list_item.dart';

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
              child: _cities.length == 0
                  ? Padding(
                      padding: EdgeInsets.all(20),
                      child: _cityName == null
                          ? Text("Enter city name...")
                          : Text(
                              "<< City not found >>",
                              style: TextStyle(color: Colors.redAccent),
                            ),
                    )
                  : ListView.builder(
                      itemCount: _cities.length,
                      itemBuilder: (context, index) {
                        final city = _cities[index];

                        return AddCityListItem(
                          cityName: city.name,
                          onTap: () => onTapItem(city.name),
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
    if (text == "" || text.length == 0) {
      setState(() {
        _cities.clear();
        _cityName = null;
      });
    } else {
      await widget.appState.api.getCities(text).then((value) {
        setState(() {
          _cities = value;
          _cityName = value.isEmpty ? "" : value.first.name;
        });
      });
    }
  }
}
