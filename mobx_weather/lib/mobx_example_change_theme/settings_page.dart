import 'package:flutter/material.dart';
import 'package:mobx_weather/app/constants.dart';
import 'package:mobx_weather/mobx_example_change_theme/theme_store.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeStore = Provider.of<ThemeStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.exampleChangeThemeSettings),
      ),
      body: Center(
        child: MaterialButton(
          color: Colors.deepPurple,
          textColor: Colors.white,
          onPressed: () {
            ThemeType changeTo = themeStore.currentThemeType == ThemeType.light
                ? ThemeType.dark
                : ThemeType.light;
            themeStore.changeCurrentTheme(changeTo);
          },
          child: Text(Constants.exampleChangeThemeButton),
        ),
      ),
    );
  }
}
