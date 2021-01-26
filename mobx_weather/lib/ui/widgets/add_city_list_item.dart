import 'package:flutter/material.dart';
import 'package:mobx_weather/app/constants.dart';

class AddCityListItem extends StatelessWidget {
  final String cityName;
  final Function onTap;

  const AddCityListItem({
    Key key,
    this.cityName = Constants.emptyCityName,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(cityName),
        leading: IconButton(
          icon: CircleAvatar(
            child: Icon(Icons.add),
          ),
        ),
        onTap: onTap,
      ),
      elevation: 10,
    );
  }
}
