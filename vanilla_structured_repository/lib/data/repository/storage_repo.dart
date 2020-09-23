import 'package:vanilla_structured_repository/model/city.dart';

abstract class StorageRepository {
  Future<void> saveCity(City city);

  Future<void> saveCities(List<City> cities);

  Future<List<City>> getAllCities();

  Future<void> addCity(City city);

  Future<void> updateCity(City city);

  Future<void> deleteCity(City city);
}
