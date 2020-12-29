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
The same weather app, but implemented with different architecture approaches.

#### vanilla
Just make an app, don't think about architecture, readability, how to add new features or fix bugs. One file to rule it all.

#### vanilla_structured_repository
Separate simple vanilla to different files.
Add a repository pattern to get data.
Move ui to screens and custom widgets.
Use models.

#### bloc
BLoC pattern implementation. Sinks for Inputs and Streams for Outputs. Data driven UI. Without any packages.

#### bloc_pub
BLoC pattern with help of packages: bloc and flutter_bloc.

#### provider
Recommendation from Google.
Flexible and configurable for different use cases.

#### scoped_model
Scoped model pattern implementation. Scoped model library was originally extracted from the Fuchsia codebase.
Scoped model is like a simplified version of Provider, or Provider for Dummies.
Straightforward and easy to use.
