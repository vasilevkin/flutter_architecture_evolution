import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_weather/app/constants.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_change_theme/settings_page.dart';
import 'package:mobx_weather/mobx_examples/mobx_example_change_theme/theme_store.dart';
import 'package:provider/provider.dart';

class ChangeThemeHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.exampleChangeThemeTitle),
        actions: [
          IconButton(
              icon: Icon(Icons.brightness_medium),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => Observer(
                    builder: (_) {
                      final themeStore = Provider.of<ThemeStore>(context);
                      return SimpleDialog(
                        title: Text(Constants.exampleChangeThemeSelectTheme),
                        children: [
                          ListTile(
                            title:
                                const Text(Constants.exampleChangeThemeLight),
                            leading: Radio(
                              value: ThemeType.light,
                              groupValue: themeStore.currentThemeType,
                              onChanged: (ThemeType value) {
                                themeStore.changeCurrentTheme(value);
                                print(
                                    'MobX_ChangeThemeExample:: current theme = $value');
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text(Constants.exampleChangeThemeDark),
                            leading: Radio(
                              value: ThemeType.dark,
                              groupValue: themeStore.currentThemeType,
                              onChanged: (ThemeType value) {
                                themeStore.changeCurrentTheme(value);
                                print(
                                    'MobX_ChangeThemeExample:: current theme = $value');
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              elevation: 20,
              child: Observer(
                builder: (context) => ListTile(
                  title: Text(
                      '${Constants.exampleChangeThemeCurrent} ${Provider.of<ThemeStore>(context).themeString}'),
                ),
              ),
            ),
            SizedBox(
              height: 150,
            ),
            MaterialButton(
              color: Colors.deepPurple,
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsPage()));
              },
              child: Text(Constants.exampleChangeThemeGoToSettings),
            ),
          ],
        ),
      ),
    );
  }
}
