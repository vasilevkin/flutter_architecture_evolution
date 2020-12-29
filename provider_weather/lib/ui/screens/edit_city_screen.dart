import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_weather/data_models/city.dart';
import 'package:provider_weather/ui/widgets/add_city_list_item.dart';
import 'package:provider_weather/ui/widgets/loader.dart';
import 'package:provider_weather/view_models/add_city_viewmodel.dart';

class EditCityScreen extends StatelessWidget {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AddCityViewModel>(context, listen: true);

    return WillPopScope(
      onWillPop: () async {
        viewModel.clearViewModel();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit City: ${viewModel.selectedCityName}'),
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

  Widget _buildScreenBody(AddCityViewModel viewModel) {
    if (viewModel == null || viewModel.isLoading == true) {
      return Center(child: Loader());
    }
    if (viewModel.error != null) {
      return _buildErrorMessage(text: viewModel.error.message);
    }
    if (viewModel.suggestionsList == null) {
      return Text('Please enter a new city name...');
    }
    return _buildSuggestionsList(
        viewModel: viewModel, cities: viewModel.suggestionsList);
  }

  Widget _buildSuggestionsList({
    @required AddCityViewModel viewModel,
    @required List<City> cities,
  }) {
    return ListView.builder(
      itemCount: cities.length,
      itemBuilder: (context, index) {
        final city = cities[index];

        return AddCityListItem(
          cityName: city.name,
          onTap: () =>
              onTapItem(context: context, viewModel: viewModel, city: city),
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

  void onTapItem({
    @required BuildContext context,
    @required AddCityViewModel viewModel,
    @required City city,
  }) {
    viewModel.updateCity(city);
    Navigator.pop(context);
  }
}
