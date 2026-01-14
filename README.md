## Description
Inventory Management System created using Flutter Web. The backend code can be see on <a href=https://github.com/hezbims/Backend-Inventory-System-NET>this link</a>

## Backend Integration 
- Add `env_file` in root project. The example is on `env_file.example`.
- Copy the `swagger.json` from backend endpoint (`http://localhost:5154/swagger/v1/swagger.json`), to folder `api_spec`.
- Install Node `v22.11.0`
- Install the OpenAPI Spec model generator :
  ```sh
  sudo npm i -g  @openapitools/openapi-generator-cli@2.25.2
  ```
- Run this command to  re-generate the API Models from OpenAPI Spec :
  ```sh
  npm run gen
  ``` 
  the model will be generated in folder `common/lib/data/generated_api_dto`

## Running App
1. Install <b>[fvm](https://fvm.app/)</b> `v4.0.5`.
2. Run this two command to fetch the dependencies from pubspec :
   ```sh
   fvm dart pub global activate melos --version 4.0.5
   fvm dart pub global run melos bootstrap
   ```
3. Run this command to generate web worker for faster PDF generation :
   ```sh
   fvm dart run isolate_manager:generate -i "C:\ABSOLUTE_PATH_TO_PROJECT\frontend_inventory_system\fitur\fitur_buat_laporan"
   ```
   for debugging purpose, use this command instead :
   ```sh
   fvm dart run isolate_manager:generate -i "C:\ABSOLUTE_PATH_TO_PROJECT\frontend_inventory_system\fitur\fitur_buat_laporan" --debug --obfuscate 0
   ```
4. Finally run the app in the chrome browser :
   ```sh
   fvm flutter run -d chrome
   ```

## Running Test
### Integration Test
#### Prerequisite 
1. Install `stoplight/prism` to run mock server on OpenAPI Spec
   ```sh
   sudo npm i -g @stoplight/prism-cli@5.14.2
   ```
2. Install Chrome :
   ```sh
   sudo npx -y @puppeteer/browsers install chrome@119.0.6045
   ```
3. Install Chromedriver :
   ```sh
   sudo npx -y @puppeteer/browsers install chromedriver@119.0.6045
   ```
   

#### Running Integration Test

1. Run the prism mock server like this :
   ```sh
   # If the spec is accessible in local folder
   prism mock ./api_spec/swagger.json
   
   # if the spec is accessible on an URL
   prism mock http://127.0.0.1:5154/swagger/v1/swagger.json
   ```
   
   you can then check it by using `curl` like this :
   ```sh
   curl -X POST http://127.0.0.1:4010/api/login \
    -H 'Content-type: application/json' \
    -H 'Accept: application/json' \
    -d '{ "username": "admin", "password": "somePassword123#" }'
   ```
   
2. Then run Chromedriver like this :
   ```sh
   chromedriver --port=4444
   ``` 

3. Then finally run the Flutter Web integration test :
   ```sh
   fvm flutter drive \
   --driver=test_driver/integration_test_driver.dart \
   --target=integration_test/<INTEGRATION_TEST_FILE>.dart \
   -d chrome
   ```

## Project Structure
### App

### Test (Target)
<!-- Editable 
frontend_inventory_system
  api_spec
    swagger.json # OpenAPI specification from backend
  common
    test_support
      utils
  feature
    product
      test_support
        mock # Contains spy or mock
        steps # Reusable steps (user flow action) across multiple screen (Optional)
        robot # Classes for controlling a screen
      test
        service # Testing Repository implementation or contract testing
        user_flow # User acceptance testing
    transaction
      test_support
      robot
    reporting
      test_support
      robot
  integration_test
    e2e_test
    integration_test
      auth # Only happy flow, because it includes localStorage (shared preference)
        login_test.dart
        logout_test.dart
  test
    dependency_injection 
    routing # Make sure route state match opened screen
  test_driver # Flutter web driver for integration test
-->
```
frontend_inventory_system
├── api_spec
│   └── swagger.json # OpenAPI specification from backend
├── common
│   └── test_support
│       └── utils
├── feature
│   ├── product
│   │   ├── test_support
│   │   │   ├── mock # Contains spy or mock
│   │   │   ├── steps # Reusable steps (user flow action) across multiple screen (Optional)
│   │   │   └── robot # Classes for controlling a screen
│   │   └── test
│   │       ├── service # Testing Repository implementation or contract testing
│   │       └── user_flow # User acceptance testing
│   ├── transaction
│   │   ├── test_support
│   │   └── robot
│   └── reporting
│       ├── test_support
│       └── robot
├── integration_test
│   ├── e2e_test
│   └── integration_test
│       └── auth # Only happy flow, because it includes localStorage (shared preference)
│           ├── login_test.dart
│           └── logout_test.dart
├── test
│   ├── dependency_injection 
│   └── routing # Make sure route state match opened screen
└── test_driver # Flutter web driver for integration test
```

   
## Jetbrains IDE Setup (Opsional)
To hide generated worker file by `isolate_manager` :
1. Go to **Settings** > **Editor** > **File Types** > **Ignored Files and Folders**
2. Then add this : 
   ```
   .IsolateManagerWorker*.dart
   ```