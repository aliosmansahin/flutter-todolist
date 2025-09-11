# flutter-todolist
A simple task management application made with Flutter, designed for one-handed use and featuring mostly neumorphism design style.

## Screenshots
<img src="screenshots/s1.png" alt="Screenshot 1" width="200">   <img src="screenshots/s2.png" alt="Screenshot 2" width="200">   <img src="screenshots/s3.png" alt="Screenshot 3" width="200">   <img src="screenshots/s4.png" alt="Screenshot 4" width="200">   <img src="screenshots/s5.png" alt="Screenshot 5" width="200">   <img src="screenshots/s6.png" alt="Screenshot 6" width="200">   <img src="screenshots/s7.png" alt="Screenshot 7" width="200">

## Features
  * CRUD Operations - Create, read, update and delete tasks
  * Task Tabs - All, Today, Upcoming...
  * Push Notifications - Get notifications on deadline of tasks
  * Smooth UX - Ergonomic and clean design with mostly neumorphism style

## Built With
  * Framework: [Flutter][flutter-url]
  * Language: [Dart][dart-url]
  * Packages:
    * State Management: [provider][provider-url]
    * Notifications: [awesome_notifications][awesome-notifications-url]
    * Local Database:
      * [drift][drift-url]
      * [drift_sqflite][drift-sqflite-url]
      * For Building Database:
        * [drift_dev][drift-dev-url]
        * [build_runner][build-runner-url]

## Installation
1. Clone the repo
```sh
git clone https://github.com/aliosmansahin/flutter-todolist.git
```
2. Get necessary packages
```sh
flutter pub get
```
3. Edit some lines
   * [app/build.gradle][build-gradle-edit-url]
   * [app/build.gradle][build-gradle-edit-url-2]
   * [MainActivity.kt][mainactivity.kt-edit-url]
5. Run the app
```sh
flutter run
```

## PS
This project is currently coded and tested only for Android. It may have issues on different platforms.

<!-- LINKS -->
[flutter-url]: https://flutter.dev/
[dart-url]: https://dart.dev/
[provider-url]: https://pub.dev/packages/provider
[awesome-notifications-url]: https://pub.dev/packages/awesome_notifications
[drift-url]: https://pub.dev/packages/drift
[drift-sqflite-url]: https://pub.dev/packages/drift_sqflite
[drift-dev-url]: https://pub.dev/packages/drift_dev
[build-runner-url]: https://pub.dev/packages/build_runner
[build-gradle-edit-url]: https://github.com/aliosmansahin/flutter-todolist/blob/d32fad366aa5e04e7fdc5ec50ce26a3dea57256d/android/app/build.gradle.kts#L9
[build-gradle-edit-url-2]: https://github.com/aliosmansahin/flutter-todolist/blob/d32fad366aa5e04e7fdc5ec50ce26a3dea57256d/android/app/build.gradle.kts#L25
[mainactivity.kt-edit-url]: https://github.com/aliosmansahin/flutter-todolist/blob/d32fad366aa5e04e7fdc5ec50ce26a3dea57256d/android/app/src/main/kotlin/com/example/todolist/MainActivity.kt#L1
