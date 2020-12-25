import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_weather/data_models/city.dart';
import 'package:provider_weather/ui/widgets/add_city_list_item.dart';
import 'package:provider_weather/view_models/add_city_viewmodel.dart';

class AddCityScreen extends StatefulWidget {


  @override
  _AddCityScreenState createState() => _AddCityScreenState();
}

class _AddCityScreenState extends State<AddCityScreen> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AddCityViewModel viewModel;

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<AddCityViewModel>(context, listen: true);

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
                onChanged: (value) => viewModel.queryString.add(value),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<City>>(
                stream: viewModel.suggestionsList,
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
    viewModel.selectedCityName.add(name);
    Navigator.pop(context);
  }
}
