import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_weather/data_models/city.dart';
import 'package:provider_weather/ui/widgets/add_city_list_item.dart';
import 'package:provider_weather/ui/widgets/loader.dart';
import 'package:provider_weather/view_models/add_city_viewmodel.dart';

class AddCityScreen extends StatefulWidget {
  @override
  _AddCityScreenState createState() => _AddCityScreenState();
}

class _AddCityScreenState extends State<AddCityScreen> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AddCityViewModel viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    viewModel = Provider.of<AddCityViewModel>(context, listen: true);
  }

  @override
  void dispose() {
    viewModel.clearViewModel();
    // viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        viewModel.clearViewModel();
        return true;
      },
      child: Scaffold(
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
                  onChanged: (value) => viewModel.setQueryString(value),
                ),
              ),
              Expanded(
                child: _buildScreenBody(viewModel),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScreenBody(AddCityViewModel model) {
    if (model == null || model.isLoading == true) {
      return Center(child: Loader());
    }
    if (model.error != null) {
      return _buildErrorMessage(text: model.error.message);
    }
    if (model.suggestionsList == null) {
      return Text("Enter city name...");
    }
    return _buildSuggestionsList(cities: model.suggestionsList);
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
    viewModel.setSelectedCityName(name);
    Navigator.pop(context);
  }
}
