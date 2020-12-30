import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:scoped_model_weather/app/app_routes.dart';
import 'package:scoped_model_weather/data_models/city.dart';
import 'package:scoped_model_weather/ui/widgets/home_list_item.dart';
import 'package:scoped_model_weather/ui/widgets/loader.dart';
import 'package:scoped_model_weather/view_models/app_scoped_model.dart';
import 'package:scoped_model_weather/view_models/home_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScopedModel scopedModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // scopedModel = ScopedModel.of<AppScopedModel>(context, rebuildOnChange: true).homeScopedModel;
    scopedModel = ScopedModel.of<HomeScopedModel>(context, rebuildOnChange: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scoped Model Weather')),
      body: Center(
        child: _buildScreenBody(scopedModel),
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildScreenBody(HomeScopedModel model) {
    // return ScopedModelDescendant<AppScopedModel>(
    //   rebuildOnChange: true,
    return ScopedModelDescendant<HomeScopedModel>(
        builder: (context, child, model) {
    //   if (model.homeScopedModel == null) {
    //     return Loader();
    //   }
    //   if (model.homeScopedModel.error != null) {
    //     return Text('${model.homeScopedModel.error}');
    //   }
    //   if (model.homeScopedModel.citiesList == null) {
    //     return Loader();
    //   }
    //   return _buildCitiesList(cities: model.homeScopedModel.citiesList);
    //   //   builder: (context, child, model) {
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
            scopedModel.getImageForStateAbbr(cityWeatherStateAbbr);

        return HomeListItem(
          cityName: cities[index].name,
          temperature: cities[index].weather?.theTemp,
          weatherStateImage: weatherImage,
          onTap: () => _showCityDetailScreen(cities[index]),
          onEditTap: () => _showEditCityScreen(cities[index]),
          onDeleteTap: () => scopedModel.deleteCity(cities[index]),
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
    scopedModel.setSelectedCity(city);
    Navigator.pushNamed(context, ScopedModelWeatherAppRoutes.cityDetail);
  }

  void _showEditCityScreen(City city) {
    scopedModel.setSelectedCity(city);
    Navigator.pushNamed(context, ScopedModelWeatherAppRoutes.editCity);
  }
}
