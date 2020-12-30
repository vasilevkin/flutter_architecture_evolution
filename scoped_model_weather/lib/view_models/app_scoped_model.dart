import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:scoped_model_weather/data/repository/storage_repo.dart';
import 'package:scoped_model_weather/view_models/add_or_edit_city_viewmodel.dart';
import 'package:scoped_model_weather/view_models/home_viewmodel.dart';

class AppScopedModel extends Model {
  final StorageRepository repo;
  HomeScopedModel homeScopedModel;
  AddOrEditCityViewModel addOrEditCityViewModel;

  AppScopedModel({@required this.repo}) {
    homeScopedModel = HomeScopedModel(repo: repo);

    addOrEditCityViewModel = AddOrEditCityViewModel(repo: repo);

    // homeScopedModel.loadCitiesList();
  }


  static AppScopedModel of(BuildContext context) =>
      ScopedModel.of<AppScopedModel>(context, rebuildOnChange: true);

}
