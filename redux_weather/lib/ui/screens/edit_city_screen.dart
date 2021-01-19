import 'package:flutter/material.dart';
import 'package:redux_weather/app/error_messages.dart';
import 'package:redux_weather/data_models/city.dart';
import 'package:redux_weather/scoped_models/add_or_edit_city_scoped_model.dart';
import 'package:redux_weather/ui/widgets/add_city_list_item.dart';
import 'package:redux_weather/ui/widgets/loader.dart';
import 'package:scoped_model/scoped_model.dart';

/*
Both AddCityScreen and EditCityScreen are using the same scopedModel AddOrEditCityScopedModel.
The screens are really similar, and definitely could be implemented in class file in production.
But for now, AddCityScreen is StatefulWidget,
while EditCityScreen is StatelessWidget.
For teaching purposes only.
*/

class EditCityScreen extends StatelessWidget {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final scopedModel = ScopedModel.of<AddOrEditCityScopedModel>(context,
        rebuildOnChange: true);

    return WillPopScope(
      onWillPop: () async {
        scopedModel.clearScopedModel();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit City: ${scopedModel.selectedCityName}'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Form(
                key: formKey,
                autovalidate: false,
                child: TextFormField(
                  onChanged: (value) => scopedModel.setQueryString(value),
                ),
              ),
              Expanded(
                child: _buildScreenBody(scopedModel),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScreenBody(AddOrEditCityScopedModel model) {
    if (model == null || model.isLoading == true) {
      return Center(child: Loader());
    }
    if (model.error != null) {
      return _buildErrorMessage(text: model.error.message);
    }
    if (model.suggestionsList == null) {
      return Text('Please enter a new city name...');
    }
    return _buildSuggestionsList(
        scopedModel: model, cities: model.suggestionsList);
  }

  Widget _buildSuggestionsList({
    @required AddOrEditCityScopedModel scopedModel,
    @required List<City> cities,
  }) {
    return ListView.builder(
      itemCount: cities.length,
      itemBuilder: (context, index) {
        final city = cities[index];

        return AddCityListItem(
          cityName: city.name,
          onTap: () =>
              onTapItem(context: context, scopedModel: scopedModel, city: city),
        );
      },
    );
  }

  Widget _buildErrorMessage({String text}) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: text == ErrorMessages.emptySearchString
          ? Text(text)
          : Text(text, style: TextStyle(color: Colors.redAccent)),
    );
  }

  void onTapItem({
    @required BuildContext context,
    @required AddOrEditCityScopedModel scopedModel,
    @required City city,
  }) {
    scopedModel.updateCity(city);
    Navigator.pop(context);
  }
}
