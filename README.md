# flutter_architecture_evolution
Architecture for Flutter apps.

## Some mobile app example
Most of mobile apps work very similar.
Go to a backend endpoint, get a JSON, parse it and show in a table, when user taps table's row, show details.
(CRUD create, read, update, delete)

Implement a simple Weather app using different architectures.
Compare architecture and approaches to build modern mobile apps using Flutter.

### Weather app description
Main screen: list of cities (name and current temperature)
Tap any row: show detailed weather in the selected location.
Ability to add, edit, delete items in list.

### Backend (server side)
https://www.metaweather.com/ - a great simple weather API with forecast.

End-points:
/api/location/search/?query={cityName} , search city by name and get woeId (Weather On Earth Id)
/api/location/{woeId} , get weather for a location Id

## Architecture
vanilla
vanilla_structured_repository
