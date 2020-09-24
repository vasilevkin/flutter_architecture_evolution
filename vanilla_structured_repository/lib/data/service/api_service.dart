import 'package:vanilla_structured_repository/model/city.dart';
import 'package:vanilla_structured_repository/model/weather.dart';

abstract class ApiService {
  Future<City> getCity(String text);

  Future<List<City>> getCities(String name);

  Future<Weather> getWeather(City city);
}
