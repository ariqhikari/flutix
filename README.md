<p align="center"><a href="https://play.google.com/store/apps/details?id=com.ariqhh.flutix"><img src="https://raw.githubusercontent.com/ariqhikari/flutix/main/github/logo.png" width="150"></a></p>

## About Flutix

Flutix is a mobile application (IOS & Android) that helps people to buy movie tickets online through their respective cellphones. Flutix also uses a **data collection** method to display movies that match the user's profile.

<p align="center"><a href="https://play.google.com/store/apps/details?id=com.ariqhh.flutix"><img src="https://raw.githubusercontent.com/ariqhikari/flutix/main/github/mockup.jpg"></a></p>

## Table of contents

+ [Demo](#demo)
+ [Features](#features)
+ [Technology](#technology)
+ [Installation](#installation)
+ [License](#license)

## Demo

Checkout the Demo [here](https://infoin.auroraweb.id/).

## Features

- Auth
- User Management
- Now Playing Movies
- Select Cinema
- Select Schedule
- E-Wallet (for ticket transaction)
- Data Collection (genre dan preferred language)

## Technology

- [Dart](https://dart.dev/)
- [Flutter](https://flutter.dev/)
- [Firebase](https://firebase.google.com/)

## Installation

Clone the repo:
```shell
git clone https://github.com/ariqhikari/flutix.git
cd flutix
```

Get [**Movie API**](https://developers.themoviedb.org/3/getting-started/introduction)

Put API Key in **lib/shared/shared_value.dart**
```shell
String apiKEY = "<YOUR_API_KEY_HERE>";
```

After that, run your application:
```shell
flutter packages get
flutter run
```

## License

The project is under the [MIT license](https://github.com/ariqhikari/flutix/blob/main/LICENSE).