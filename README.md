# Movies App

## Overview
This project is a modular Flutter application following Clean Architecture principles. It is designed to be scalable, maintainable, and testable by separating concerns into different modules and layers. The application supports multiple flavors and utilizes `get_it` for dependency injection and `auto_route` for navigation.

## Architecture
The project follows **Clean Architecture**, dividing the codebase into three primary layers:

### 1. **Presentation Layer**
   - Contains UI components (Widgets, Screens)
   - Uses `Bloc` and `Cubit` for state management
   - Interacts with the domain layer via `UseCases`

### 2. **Domain Layer**
   - Defines business logic with `UseCases`
   - Contains abstract `Repositories` implemented in the data layer
   - Uses the `Either` type for error handling

### 3. **Data Layer**
   - Contains repositories that implement domain contracts
   - Uses data sources (`RemoteDataSource`, `LocalDataSource`)
   - Handles API communication with `Dio` and local storage with `Hive`

## Modularization
The application is split into several modules to improve separation of concerns:

- **`movies_module`**: Manages movie-related features (listings, details, etc.).
- **`favorites_module`**: Manages favorite movies with a local database (Hive).
- **`shared_module`**: Contains common utilities, models, and shared logic.
- **`router_module`**: Manages app navigation with `auto_route`.

## Navigation
The project uses `auto_route` for declarative routing. Routes are structured as:

- **`shared_module`**:
  - `/home`: Root page with bottom navigation.
  - `/splash`: Initial loading screen.
- **`movies_module`**:
  - `/movies`: Movie listings.
  - `/movie/:id`: Movie details.
- **`favorites_module`**:
  - `/favorites`: List of favorite movies.

Navigation is handled through the `router_module`, and `GetIt` is used to provide `AppRouter` as a singleton.

## Dependency Injection
The app uses `get_it` for dependency injection. Each module registers its dependencies in a dedicated locator:

```dart
final moviesLocator = GetIt.instance;

Future<void> initMoviesLocator() async {
  moviesLocator
    ..registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(datasource: moviesLocator<MoviedbDatasource>()),
    )
    ..registerLazySingleton<GetMoviesUseCase>(
      () => GetMoviesUseCase(moviesLocator<MovieRepository>()),
    );
}
```

## Running the Application
The application is **flavorized**, meaning it supports different environments (e.g., dev, prod). To run the app, execute one of the environment-specific main files:

```sh
flutter run -t lib/environments/main_dev.dart
```

or

```sh
flutter run -t lib/environments/main_prod.dart
```

## Testing
Unit and widget tests are written for business logic and UI components.

Run tests with:
```sh
flutter test
```

## Summary
- **Modular Clean Architecture** for maintainability.
- **`auto_route` for navigation** with a dedicated `router_module`.
- **`get_it` for dependency injection**.
- **Uses flavors** to manage multiple environments.
- **State management with Bloc/Cubit** for efficient UI updates.

This architecture ensures scalability and testability while keeping the project well-structured.


Heavily inspired by Fernando Herrera´s  https://github.com/Klerith/flutter-cinemapedia/