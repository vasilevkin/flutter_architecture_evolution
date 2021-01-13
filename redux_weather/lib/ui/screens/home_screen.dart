import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux_weather/app/app_routes.dart';
import 'package:redux_weather/data_models/city.dart';
import 'package:redux_weather/redux/store.dart';
import 'package:redux_weather/scoped_models/home_scoped_model.dart';
import 'package:redux_weather/ui/widgets/home_list_item.dart';
import 'package:redux_weather/ui/widgets/loader.dart';
import 'package:scoped_model/scoped_model.dart';

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

  HomeScopedModel scopedModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    scopedModel =
        ScopedModel.of<HomeScopedModel>(context, rebuildOnChange: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, ReduxWeatherAppRoutes.example);
            },
            child: Icon(Icons.redeem),
          ),
        ],
      ),
      body: Center(
        child: _buildScreenBody(
            // scopedModel
            ),
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildScreenBody() {
    return Column(
      children: [
        StoreConnector<AppState, bool>(
          distinct: true,
          converter: (store) => store.state.cityState.isLoading,
          builder: (context, isLoaging) {
            return (isLoaging == true) ? Loader() : SizedBox.shrink();
          },
        ),
        StoreConnector<AppState, bool>(
          distinct: true,
          converter: (store) => store.state.cityState.isError,
          builder: (context, isError) {
            return isError ? Text('Failed to fetch cities') : SizedBox.shrink();
          },
        ),
        Expanded(
          child: StoreConnector<AppState, List<City>>(
            distinct: true,
            converter: (store) => store.state.cityState.cities,
            builder: (context, cities) => _buildCitiesList(cities: cities),
          ),
        ),
      ],
    );

    // return ScopedModelDescendant<HomeScopedModel>(
    //   builder: (context, child, model) {
    //     if (model == null) {
    //       return Loader();
    //     }
    //     if (model.error != null) {
    //       return Text('${model.error}');
    //     }
    //     if (model.citiesList == null) {
    //       return Loader();
    //     }
    //     return _buildCitiesList(cities: model.citiesList);
    //   },
    // );
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
    Navigator.pushNamed(context, ReduxWeatherAppRoutes.addCity);
  }

  void _showCityDetailScreen(City city) {
    scopedModel.setSelectedCity(city);
    Navigator.pushNamed(context, ReduxWeatherAppRoutes.cityDetail);
  }

  void _showEditCityScreen(City city) {
    scopedModel.setSelectedCity(city);
    Navigator.pushNamed(context, ReduxWeatherAppRoutes.editCity);
  }
}
