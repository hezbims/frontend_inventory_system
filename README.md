## Description
Inventory Management System created using Flutter Web. The backend code can be see on <a href=https://github.com/hezbims/Backend-Inventory-System-NET>this link</a>

## Env Setup
Add `env_file` in root project. The example is on `env_file.example`.

## Running
To run the the app you must install [fvm](https://fvm.app/) first.

And then run this two command to fetch the dependencies :
```
fvm dart pub global activate melos
fvm dart pub global run melos bootstrap
```

And then run this to run the app in the chrome browser :
```
fvm flutter run -d chrome
```