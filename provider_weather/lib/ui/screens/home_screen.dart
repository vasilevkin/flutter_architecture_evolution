import 'package:provider/provider.dart';
import 'package:provider_weather/app/app_routes.dart';
import 'package:provider_weather/model/home_viewmodel.dart';
import 'package:provider_weather/data/repository/storage_repo.dart';
import 'package:provider_weather/data_models/city.dart';
import 'package:provider_weather/ui/widgets/home_list_item.dart';
import 'package:provider_weather/ui/widgets/loader.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    model = Provider.of<HomeViewModel>(context, listen: true);
  }

  @override
  void dispose() {
    model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Provider Weather')),
      body: Center(
        child: _buildScreenBody(model),
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildScreenBody(HomeViewModel model) {
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
  }

  Widget _buildCitiesList({List<City> cities}) {
    if (cities.length == 0) return Text('Tap + to add a new city...');

    return ListView.builder(
      itemCount: cities.length,
      itemBuilder: (context, index) {
        final cityWeatherStateAbbr =
            cities[index].weather?.weatherStateAbbr ?? 'hc';
        final weatherImage = model.getImageForStateAbbr(cityWeatherStateAbbr);

        return HomeListItem(
          cityName: cities[index].name,
          temperature: cities[index].weather?.theTemp,
          weatherStateImage: weatherImage,
          onTap: () => _showCityDetailScreen(cities[index]),
          onEditTap: () => _showEditCityScreen(cities[index]),
          onDeleteTap: () => model.deleteCity(cities[index]),
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
    Navigator.pushNamed(context, ProviderWeatherAppRoutes.addCity);
  }

  void _showCityDetailScreen(City city) {
    model.setSelectedCity(city);
    Navigator.pushNamed(context, ProviderWeatherAppRoutes.cityDetail);
  }

  void _showEditCityScreen(City city) {
    model.setSelectedCity(city);
    Navigator.pushNamed(context, ProviderWeatherAppRoutes.editCity);
  }
}
