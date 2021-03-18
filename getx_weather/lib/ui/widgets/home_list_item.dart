import 'package:flutter/material.dart';
import 'package:getx_weather/app/constants.dart';

class HomeListItem extends StatelessWidget {
  final String cityName;
  final num temperature;
  final Image weatherStateImage;
  final Function onTap;
  final Function onEditTap;
  final Function onDeleteTap;

  HomeListItem({
    this.cityName = Constants.emptyCityName,
    this.temperature = 0,
    this.weatherStateImage,
    this.onTap,
    this.onEditTap,
    this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(cityName),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${temperature?.toInt()} ${Constants.degreeUnit}'),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Container(
                height: 30,
                child: weatherStateImage,
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: onEditTap,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: onDeleteTap,
            ),
          ],
        ),
        onTap: onTap,
      ),
      elevation: 10,
    );
  }
}
