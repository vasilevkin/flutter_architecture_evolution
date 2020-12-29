import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:scoped_model_weather/data/repository/storage_repo.dart';
import 'package:scoped_model_weather/view_models/home_viewmodel.dart';

class AppScopedModel extends Model {
  final StorageRepository repo;
  HomeScopedModel homeScopedModel;

  AppScopedModel({@required this.repo}) {
    homeScopedModel = HomeScopedModel(repo: repo);
  }
}
