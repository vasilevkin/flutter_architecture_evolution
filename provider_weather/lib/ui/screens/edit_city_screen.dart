import 'package:provider_weather/model/edit_city_bloc.dart';
import 'package:provider_weather/data/repository/storage_repo.dart';
import 'package:provider_weather/data_models/city.dart';
import 'package:provider_weather/ui/widgets/add_city_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditCityScreen extends StatelessWidget {
  final StorageRepository repo;
  final EditCityBloc editCityBloc;
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  EditCityScreen({
    @required this.repo,
  })  : assert(repo != null),
        editCityBloc = EditCityBloc(repo);

  @override
  Widget build(BuildContext context) {
    final _city = repo.getSelectedCity();

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit City: ${_city.name}"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: formKey,
              autovalidate: false,
              child: TextFormField(
                onChanged: (value) => editCityBloc.queryString.add(value),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<City>>(
                stream: editCityBloc.suggestionsList,
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
          onTap: () => onTapItem(city, context),
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

  void onTapItem(City city, BuildContext context) {
    editCityBloc.selectedCityName.add(city);
    Navigator.pop(context);
  }
}
