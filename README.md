## Description
Inventory Management System created using Flutter Web. The backend code can be see on <a href=https://github.com/hezbims/Backend-Inventory-System-NET>this link</a>

## Env Setup
Add `env_file` in root project. The example is on `env_file.example`.

## Running
1. Install <b>[fvm](https://fvm.app/)</b> first.
2. Run this two command to fetch the dependencies from pubspec :
   ```
   fvm dart pub global activate melos
   fvm dart pub global run melos bootstrap
   ```
3. Run this command to generate web worker for PDF generation :
   ```
   fvm dart run isolate_manager:generate -i "C:\ABSOLUTE_PATH_TO_PROJECT\frontend_inventory_system\fitur\fitur_buat_laporan"
   ```
   for debugging purpose, use this command instead :
   ```
   fvm dart run isolate_manager:generate -i "C:\ABSOLUTE_PATH_TO_PROJECT\frontend_inventory_system\fitur\fitur_buat_laporan" --debug --obfuscate 0
   ```
4. Finally run the app in the chrome browser :
   ```
   fvm flutter run -d chrome
   ```
   
## Jetbrains IDE Setup (Opsional)
To hide generated worker file by `isolate_manager` :
1. Go to **Settings** > **Editor** > **File Types** > **Ignored Files and Folders**
2. Then add this : 
   ```
   .IsolateManagerWorker*.dart
   ```