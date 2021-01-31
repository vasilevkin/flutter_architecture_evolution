import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:mobx_weather/mobx_example_fake_weather/data_model/fake_weather.dart';
import 'package:mobx_weather/mobx_example_fake_weather/store/fake_weather_store.dart';
import 'package:provider/provider.dart';

class FakeWeatherSearchPage extends StatefulWidget {
  @override
  _FakeWeatherSearchPageState createState() => _FakeWeatherSearchPageState();
}

class _FakeWeatherSearchPageState extends State<FakeWeatherSearchPage> {
  FakeWeatherStore _fakeWeatherStore;
  List<ReactionDisposer> _disposers;

// For showing a SnackBar
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _fakeWeatherStore ??= Provider.of<FakeWeatherStore>(context);
    _disposers ??= [
      reaction((_) => _fakeWeatherStore.errorMessage, (String message) {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      })
    ];
  }

  @override
  void dispose() {
    _disposers.forEach((element) => element());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Fake Weather Search'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: Observer(
          builder: (_) {
            switch (_fakeWeatherStore.state) {
              case FakeStoreState.initial:
                return buildInitialInput();
              case FakeStoreState.loading:
                return buildLoading();
              case FakeStoreState.loaded:
                return buildColumnWithData(_fakeWeatherStore.fakeWeather);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget buildInitialInput() {
    return Center(
      child: CityInputField(),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(FakeWeather fakeWeather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          fakeWeather.cityName,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),
        ),
        Text(
          '${fakeWeather.temperatureCelsius.toStringAsFixed(1)} C',
          style: TextStyle(fontSize: 80),
        ),
        CityInputField(),
      ],
    );
  }
}

class CityInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => submitCityName(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Enter a city',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  void submitCityName(BuildContext context, String cityName) {
    final fakeWeatherStore = Provider.of<FakeWeatherStore>(context);

    fakeWeatherStore.getFakeWeather(cityName);
  }
}
