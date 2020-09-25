import 'package:flutter/material.dart';

class AddCityListItem extends StatelessWidget {
  final String cityName;
  final Function onTap;

  const AddCityListItem({
    Key key,
    this.cityName = "No Name",
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
