# ReusableWeatherWidget-iOS

## Installation
Run git clone to download proyect

```ruby
git clone https://github.com/luisMan97/ReusableWeatherWidget-iOS.git
```

#### Third Party Libraries
The project does not use third party libraries. Don't cocoapods, don't cartage, don't worry :)

#### Features
The main screen displays the current weather in San Jose, CA, the temperature (warm weather in the image, orange color), wind speed, etc.

![Alt text](/Resources/warm.gif "warm")

- When the weather is hot, it appears red.

![Alt text](/Resources/hot.png "hot")

- When the weather is cold, it appears blue.

![Alt text](/Resources/cold.png "cold")

- An error message is displayed when the service fails.

![Alt text](/Resources/error.png "error")

#### Technical features:
- The app is developed in Swift 6, with SwiftUI, the latest Observable framework/macro, strict concurrency, and Async/Await.
- The app uses a type of MVVM architecture with CLEAN Architecture.
- The app implements different design patterns (Factory, among others).
- The app uses dependency injection.
- The app follows SOLID principles.
- The app does not use third-party libraries.
- The app contains tests for the viewmodels.
- The app uses a generic layer with URLSession to make service calls.
- The app has a method that prints errors in a centralized way and only in debug mode.
- The app uses Codable for mapping JSON to objects.
- The app contains a .gitignore to avoid uploading unnecessary files.

#### Architecture
CLEAN Architecture was implemented, with the following layers:
1) View: Contains the SwiftUI Views
2) Presentation: Contains the ViewModels
3) Entity/Domain: Contains the entities
4) Framework: Contains the detailed implementation for data retrieval using the respective library or framework (URLSession, etc.)
