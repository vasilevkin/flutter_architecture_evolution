import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:scoped_model_weather/data_models/city.dart';
import 'package:scoped_model_weather/ui/widgets/add_city_list_item.dart';
import 'package:scoped_model_weather/ui/widgets/loader.dart';
import 'package:scoped_model_weather/view_models/add_or_edit_city_viewmodel.dart';

/*
Both AddCityScreen and EditCityScreen are using the same viewModel AddOrEditCityViewModel.
The screens are really similar, and definitely could be implemented in class file in production.
But for now, AddCityScreen is StatefulWidget,
while EditCityScreen is StatelessWidget.
For teaching purposes only.
*/

class AddCityScreen extends StatefulWidget {
  @override
  _AddCityScreenState createState() => _AddCityScreenState();
}

class _AddCityScreenState extends State<AddCityScreen> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AddOrEditCityViewModel viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    viewModel =
        ScopedModel.of<AddOrEditCityViewModel>(context, rebuildOnChange: true);
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

  Widget _buildScreenBody(AddOrEditCityViewModel model) {
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
    viewModel.addSelectedCityName(name);
    Navigator.pop(context);
  }
}
