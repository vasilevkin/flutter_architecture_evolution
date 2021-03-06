import 'package:bloc_weather/bloc/add_city_bloc.dart';
import 'package:bloc_weather/data/repository/storage_repo.dart';
import 'package:bloc_weather/model/city.dart';
import 'package:bloc_weather/ui/widgets/add_city_list_item.dart';
import 'package:flutter/material.dart';

class AddCityScreen extends StatefulWidget {
  final StorageRepository repo;

  AddCityScreen({
    @required this.repo,
  }) : assert(repo != null);

  @override
  _AddCityScreenState createState() => _AddCityScreenState();
}

class _AddCityScreenState extends State<AddCityScreen> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AddCityBloc addCityBloc;

  @override
  void initState() {
    super.initState();
    addCityBloc = AddCityBloc(widget.repo);
  }

  @override
  void dispose() {
    addCityBloc.dispose();
    super.dispose();
  }

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
                onChanged: (value) => addCityBloc.queryString.add(value),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<City>>(
                stream: addCityBloc.suggestionsList,
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return _buildSuggestionsList(cities: snapshot.data);

                  if (snapshot.hasError)
                    return _buildErrorMessage(text: snapshot.error);

                  return Text("Enter city name...");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionsList({List<City> cities}) {
    return ListView.builder(
      itemCount: cities.length,
      itemBuilder: (context, index) {
        final city = cities[index];

        return AddCityListItem(
          cityName: city.name,
          onTap: () => onTapItem(city.name),
        );
      },
    );
  }

  Widget _buildErrorMessage({String text}) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: text == 'Enter city name...'
          ? Text(text)
          : Text(text, style: TextStyle(color: Colors.redAccent)),
    );
  }

  void onTapItem(String name) {
    addCityBloc.selectedCityName.add(name);
    Navigator.pop(context);
  }
}
