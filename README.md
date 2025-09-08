# fampay-assessment

A new Flutter project intended as an assessment for FamPay.

## Overview

This repository contains the source code for a Flutter application. The project utilizes Dart as its primary programming language and is structured to be cross-platform, supporting web, Linux, and Windows builds.

## Features

- Modular Flutter application structure.
- Card management logic with both remote and local data handling.
- Built-in methods to filter and manage card groups and their visibility.
- Ready to run on multiple platforms (web, Linux, Windows).

## Demo

- [Live Demo on Web](./Demo.mp4)
-  This video consist the how dynamically the components have been rendered using the api response.

`**Note** : Current api response doesn't have '{}' in the formatted_title field so in Component HC6 and HC1 we cannot see the corresponding entity text as per the UI. `

## Getting Started

This project is a starting point for a Flutter application. To get up and running:

1. **Clone the repository:**
   ```sh
   git clone https://github.com/NishchayRajput/fampay-assessment.git
   cd fampay-assessment
   ```

2. **Install dependencies:**
   ```sh
   flutter pub get
   ```

3. **Run the app:**
    - For web:
      ```sh
      flutter run -d chrome
      ```
    - For desktop (Linux/Windows):
      ```sh
      flutter run -d linux   # or -d windows
      ```

## Project Structure

- `lib/`: Main application code.
    - `components/card_state/`: Card repository and state management.
    - `model/`: Data models for cards and groups.
    - `service/`: Remote and local services for data operations.
- `web/`, `linux/`, `windows/`: Platform-specific build and configuration files.
- `README.md`: Project documentation.

## Useful Resources

- [Flutter: Write your first app](https://docs.flutter.dev/get-started/codelab)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)
- [Flutter Documentation](https://docs.flutter.dev/)

## Requirements

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dart SDK (bundled with Flutter)

## License

This project currently does not specify a license.

---

For any questions or issues, please open an issue on the [GitHub repository](https://github.com/NishchayRajput/fampay-assessment).