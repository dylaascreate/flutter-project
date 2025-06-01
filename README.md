# flutter_plugin_lab

A Flutter project demonstrating usage and integration of 4 different plugins for common app functionalities such as image picking, local storage, URL launching, and file management.

## Plugins Used

- **image_picker** — Pick images from gallery or camera.
- **path_provider** — Access device file system paths.
- **shared_preferences** — Store simple key-value data persistently.
- **url_launcher** — Open URLs in the device's default browser.

## Features

- Pick or take photos using device camera or gallery.
- Save picked images locally in app documents directory.
- Store and retrieve image paths and URLs persistently using shared preferences.
- Launch URLs directly from the app.
- Display saved image and URL on app startup.

## Getting Started

### Prerequisites

- Flutter SDK installed (>= 3.0.0 recommended)
- Compatible device or emulator

### Installation

To clone and run the `flutter_plugin_lab` branch of this project, use the following commands:

```bash
git clone -b flutter_plugin_lab https://github.com/dylaascreate/flutter-project.git
cd flutter_project
flutter pub get
flutter run
