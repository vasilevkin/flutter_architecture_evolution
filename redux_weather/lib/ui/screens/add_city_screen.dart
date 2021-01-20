import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_weather/app/constants.dart';
import 'package:redux_weather/app/error_messages.dart';
import 'package:redux_weather/data_models/city.dart';
import 'package:redux_weather/redux/redux.dart';
import 'package:redux_weather/redux/store.dart';
import 'package:redux_weather/redux/suggestions/suggestion_actions.dart';
import 'package:redux_weather/redux/suggestions/suggestion_state.dart';
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

class AddCityScreen extends StatefulWidget {
  final void Function() onInit;

  AddCityScreen({@required this.onInit});

  @override
  _AddCityScreenState createState() => _AddCityScreenState();
}

class _AddCityScreenState extends State<AddCityScreen> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AddOrEditCityScopedModel scopedModel;

  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    scopedModel = ScopedModel.of<AddOrEditCityScopedModel>(context,
        rebuildOnChange: true);
  }

  @override
  void dispose() {
    scopedModel.clearScopedModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        scopedModel.clearScopedModel();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(Constants.addCityTitle),
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
      ),
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
          return Loader();
        }
        return _buildSuggestionsList(cities: suggestionState.suggestions);
      },
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
      child: text == ErrorMessages.emptySearchString
          ? Text(text)
          : Text(text, style: TextStyle(color: Colors.redAccent)),
    );
  }

  void onTapItem(String name) {
    scopedModel.addSelectedCityName(name);
    Navigator.pop(context);
  }
}
