import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:scoped_model_weather/app/app_routes.dart';
import 'package:scoped_model_weather/data_models/city.dart';
import 'package:scoped_model_weather/ui/widgets/home_list_item.dart';
import 'package:scoped_model_weather/ui/widgets/loader.dart';
import 'package:scoped_model_weather/view_models/home_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScopedModel viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    viewModel = ScopedModel.of<HomeScopedModel>(context, rebuildOnChange: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scoped Model Weather')),
      body: Center(
        child: _buildScreenBody(viewModel),
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildScreenBody(HomeScopedModel model) {
    return ScopedModelDescendant<HomeScopedModel>(
        builder: (context, child, model) {
      if (model == null) {
        return Loader();
      }
      if (model.error != null) {
        return Text('${model.error}');
      }
      if (model.citiesList == null) {
        return Loader();
      }
      return _buildCitiesList(cities: model.citiesList);
    });
  }

  Widget _buildCitiesList({List<City> cities}) {
    if (cities.length == 0) return Text('Tap + to add a new city...');

    return ListView.builder(
      itemCount: cities.length,
      itemBuilder: (context, index) {
        final cityWeatherStateAbbr =
            cities[index].weather?.weatherStateAbbr ?? 'hc';
        final weatherImage =
            viewModel.getImageForStateAbbr(cityWeatherStateAbbr);

        return HomeListItem(
          cityName: cities[index].name,
          temperature: cities[index].weather?.theTemp,
          weatherStateImage: weatherImage,
          onTap: () => _showCityDetailScreen(cities[index]),
          onEditTap: () => _showEditCityScreen(cities[index]),
          onDeleteTap: () => viewModel.deleteCity(cities[index]),
        );
      },
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: _tapAddCity,
      tooltip: 'Add a new city',
      child: Icon(Icons.add),
    );
  }

  void _tapAddCity() async {
    Navigator.pushNamed(context, ScopedModelWeatherAppRoutes.addCity);
  }

  void _showCityDetailScreen(City city) {
    viewModel.setSelectedCity(city);
    Navigator.pushNamed(context, ScopedModelWeatherAppRoutes.cityDetail);
  }

  void _showEditCityScreen(City city) {
    viewModel.setSelectedCity(city);
    Navigator.pushNamed(context, ScopedModelWeatherAppRoutes.editCity);
  }
}
