# cubex

Cubex assesement

A Flutter application that displays a list of African countries along with detailed information about each country.

## Features

- Display a list of all African countries
- Search functionality to filter countries by name
- Detailed view for each country with comprehensive information
- Platform-adaptive UI (Material for Android, Cupertino for iOS)
- Offline support with Hive caching
- Clean architecture with BLoC state management
- Beautiful custom theme with Africa-inspired colors
- Hero animations for smooth transitions between screens
- Google Maps integration for viewing countries and capitals

## Getting Started

### Prerequisites

- Flutter SDK (installed and configured)
- Android Studio / VSCode with Flutter extensions
- An emulator or physical device for testing

### Installation

1. Clone the repository
```bash
git clone https://github.com/sobuur0/cubex.git
```

2. Navigate to the project directory
```bash
cd cubex
```

3. Install dependencies
```bash
flutter pub get
```

4. Run the app
```bash
flutter run
```

### Building the APK

To build a release APK, run the following command:

```bash
flutter build apk --release
```

The APK file will be located at `build/app/outputs/flutter-apk/app-release.apk`.

## Architecture

The application follows Clean Architecture principles, divided into three main layers:

1. **Presentation Layer**: UI components/widgets, pages, and BLoC state management
2. **Domain Layer**: Entities, repositories interfaces, and use cases
3. **Data Layer**: Repository implementations, data sources, and models

### Project Structure

```
lib/
├── core/                  # Core utilities and constants
│   ├── constants/         # App constants including API endpoints
│   ├── di/                # Dependency injection
│   ├── errors/            # Error handling
│   ├── network/           # Network utilities
│   ├── theme/             # App theming
│   └── utils/             # Utility functions
├── data/                  # Data layer
│   ├── datasources/       # Remote and local data sources
│   ├── models/            # Data models
│   └── repositories/      # Repository implementations
├── domain/                # Domain layer
│   ├── entities/          # Business entities
│   ├── repositories/      # Repository interfaces
│   └── usecases/          # Use cases
├── presentation/          # Presentation layer
│   ├── blocs/             # BLoC state management
│   ├── pages/             # App screens
│   └── widgets/           # Reusable UI components
└── main.dart              # App entry point
```

## State Management

The app uses BLoC (Business Logic Component) pattern for state management. Each feature has its own BLoC that handles events and emits states.

- **CountriesListBloc**: Manages the state for the list of countries and search functionality
- **CountryDetailsBloc**: Manages the state for the country details screen

## Caching Strategy

The app uses Hive for local storage to provide offline capabilities:

- Countries list is cached after the first successful fetch
- Country details are cached individually when viewed
- If there's no internet connection, the app falls back to cached data

