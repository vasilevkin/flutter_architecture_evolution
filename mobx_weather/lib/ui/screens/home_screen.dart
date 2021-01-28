import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobx_weather/app/app_routes.dart';
import 'package:mobx_weather/app/constants.dart';
import 'package:mobx_weather/app/error_messages.dart';
import 'package:mobx_weather/data_models/city.dart';
import 'package:mobx_weather/redux/cities/city_actions.dart';
import 'package:mobx_weather/redux/cities/city_state.dart';
import 'package:mobx_weather/redux/redux.dart';
import 'package:mobx_weather/redux/store.dart';
import 'package:mobx_weather/ui/widgets/home_list_item.dart';
import 'package:mobx_weather/ui/widgets/loader.dart';

class HomeScreen extends StatefulWidget {
  final String title;
  final void Function() onInit;

  HomeScreen({@required this.title, @required this.onInit});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: _buildAppBarActions(),
      ),
      body: _buildScreenBody(),
      floatingActionButton: _buildFAB(),
    );
  }

  List<Widget> _buildAppBarActions() {
    return [
      TextButton(
        onPressed: () {
          Navigator.pushNamed(context, MobxWeatherAppRoutes.example);
        },
        child: Icon(Icons.rate_review),
      ),
    ];
  }

  Widget _buildScreenBody() {
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
        return _buildCitiesList(cities: cityState.cities);
      },
    );
  }

  Widget _buildCitiesList({List<City> cities}) {
    if (cities.length == 0) return Text(ErrorMessages.tapPlusToAdd);

    return ListView.builder(
      itemCount: cities.length,
      itemBuilder: (context, index) {
        return HomeListItem(
          cityName: cities[index].name,
          temperature: cities[index].weather?.theTemp,
          weatherStateImage: cities[index].imageWeather,
          onTap: () => _showCityDetailScreen(cities[index]),
          onEditTap: () => _showEditCityScreen(cities[index]),
          onDeleteTap: () =>
              Redux.store.dispatch(deleteCityAction(cities[index])),
        );
      },
    );
  }

  Widget _buildErrorMessage({String text}) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: text == ErrorMessages.tapPlusToAdd
          ? Center(child: Text(text))
          : Text(text, style: TextStyle(color: Colors.redAccent)),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: _tapAddCity,
      tooltip: Constants.addCityTitle,
      child: Icon(Icons.add),
    );
  }

  void _tapAddCity() async {
    Navigator.pushNamed(context, MobxWeatherAppRoutes.addCity);
  }

  void _showCityDetailScreen(City city) {
    Redux.store.dispatch(setSelectedCityAction(city));
    Navigator.pushNamed(context, MobxWeatherAppRoutes.cityDetail);
  }

  void _showEditCityScreen(City city) {
    Redux.store.dispatch(setSelectedCityAction(city));
    Navigator.pushNamed(context, MobxWeatherAppRoutes.editCity);
  }
}
