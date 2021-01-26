import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobx_weather/app/constants.dart';
import 'package:mobx_weather/app/error_messages.dart';
import 'package:mobx_weather/data_models/city.dart';
import 'package:mobx_weather/redux/cities/city_actions.dart';
import 'package:mobx_weather/redux/cities/city_state.dart';
import 'package:mobx_weather/redux/redux.dart';
import 'package:mobx_weather/redux/store.dart';
import 'package:mobx_weather/redux/suggestions/suggestion_actions.dart';
import 'package:mobx_weather/redux/suggestions/suggestion_state.dart';
import 'package:mobx_weather/ui/widgets/add_city_list_item.dart';
import 'package:mobx_weather/ui/widgets/loader.dart';

class EditCityScreen extends StatelessWidget {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final void Function() onInit;

/*
  AddCityScreen is StatefulWidget.
  but EditCityScreen is StatelessWidget.
  StatelessWidget is immutable, all instance fields should be final.
  List _firstRun is final, but contained data can be changed.
  This is one of the approaches to save state in StatelessWidget.
  For teaching purposes only.
*/
  final List<bool> _firstRun = [true];

  EditCityScreen({@required this.onInit});

  @override
  Widget build(BuildContext context) {
    if (_firstRun.first) {
      onInit();
      _firstRun.first = false;
    }

    return Scaffold(
      appBar: AppBar(
        title: _buildAppBarText(),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: formKey,
              autovalidate: false,
              child: TextFormField(
                onChanged: (value) =>
                    Redux.store.dispatch(fetchSuggestionsAction(value)),
              ),
            ),
            Expanded(
              child: _buildScreenBody(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBarText() {
    return StoreConnector<AppState, CityState>(
      distinct: true,
      converter: (store) => store.state.cityState,
      builder: (context, cityState) {
        if (cityState == null || cityState.isLoading) {
          return Center(child: Loader());
        }
        if (cityState.error != ErrorMessages.empty) {
          return _buildErrorMessage(text: cityState.error);
        }
        if (cityState.cities == null || cityState.cities.isEmpty) {
          return _buildErrorMessage(text: ErrorMessages.tapPlusToAdd);
        }

        return Text('${Constants.editCity} ${cityState.selectedCity.name}');
      },
    );
  }

  Widget _buildScreenBody() {
    return StoreConnector<AppState, SuggestionState>(
      distinct: true,
      converter: (store) => store.state.suggestionState,
      builder: (context, suggestionState) {
        if (suggestionState == null || suggestionState.isLoading) {
          return Center(child: Loader());
        }
        if (suggestionState.error != ErrorMessages.empty) {
          return _buildErrorMessage(text: suggestionState.error);
        }
        if (suggestionState.suggestions == null ||
            suggestionState.suggestions.isEmpty) {
          return _buildErrorMessage(text: Constants.enterNewCityName);
        }
        return _buildSuggestionsList(cities: suggestionState.suggestions);
      },
    );
  }

  Widget _buildSuggestionsList({
    @required List<City> cities,
  }) {
    return ListView.builder(
      itemCount: cities.length,
      itemBuilder: (context, index) {
        final city = cities[index];

        return AddCityListItem(
          cityName: city.name,
          onTap: () => onTapItem(context: context, city: city),
        );
      },
    );
  }

  Widget _buildErrorMessage({String text}) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: (text == ErrorMessages.emptySearchString ||
              text == Constants.enterNewCityName)
          ? Text(Constants.enterNewCityName)
          : Text(text, style: TextStyle(color: Colors.redAccent)),
    );
  }

  void onTapItem({
    @required BuildContext context,
    @required City city,
  }) {
    Redux.store.dispatch(updateCityAction(city));
    Navigator.pop(context);
  }
}
