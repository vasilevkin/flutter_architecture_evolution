import 'package:vanilla_structured_repository/model/city.dart';

abstract class StorageRepository {
  Future<List<City>> getAllCities();

  Future<void> addCity(String cityName);

  Future<void> updateCity(City city);

  Future<void> deleteCity(City city);
}
