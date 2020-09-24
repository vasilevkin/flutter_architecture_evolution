import 'package:flutter/material.dart';

class HomeListItem extends StatelessWidget {
  final String cityName;
  final num temperature;
  final Image weatherStateImage;
  final Function onTap;
  final Function onEditTap;
  final Function onDeleteTap;

  HomeListItem({
    this.cityName = "No Name",
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
            Text("${temperature.toInt()} ℃"),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: weatherStateImage,
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
