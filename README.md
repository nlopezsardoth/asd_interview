# Movies App

## Overview
This project is a **modular Flutter application** following **Clean Architecture** principles. It is designed to be **scalable, maintainable, and testable** by separating concerns into well-defined modules and layers. 

The application:
- Uses **`get_it`** for **dependency injection** to promote decoupling.
- Implements **`auto_route`** for **type-safe navigation**.
- Is **flavorized**, allowing different environments (e.g., dev, prod).
- Uses **Bloc/Cubit** for **state management**, ensuring a **reactive and predictable UI**.
- Uses **Dio** for efficient API communication and **Hive** for local storage.

---

## Architecture

This project is structured following **Clean Architecture**, which enforces a clear separation of concerns, improving **scalability, testability, and maintainability**.

### 1. **Presentation Layer**
   - Handles UI components (`Widgets`, `Screens`).
   - Uses **`Bloc` and `Cubit`** for **state management**.
   - Interacts with the **domain layer** through **use cases**.
   - Ensures that the UI remains **reactive** and **predictable**.

> **Why use Bloc/Cubit?**
> - **Separation of concerns**: The UI is completely independent of business logic.
> - **Predictable state changes**: With events and states, the application remains **deterministic**.
> - **Testability**: Bloc makes it easy to write unit tests for business logic without UI dependencies.

---

### 2. **Domain Layer**
   - Contains **business logic** in the form of **use cases**.
   - Defines **abstract repositories** to ensure that the data layer remains interchangeable.
   - Uses the `Either` type from `dartz` for **functional error handling**.

> **Why use Use Cases?**
> - **Encapsulates business logic**: Each use case represents a **single responsibility**.
> - **Improves testability**: Business logic can be tested **in isolation**.
> - **Makes the app flexible**: Since use cases don’t depend on a concrete implementation of repositories, we can swap data sources without modifying the core logic.

---

### 3. **Data Layer**
   - Implements repositories defined in the **domain layer**.
   - Uses **data sources** for API and local storage:
     - `RemoteDataSource` (API communication with **Dio**)
     - `LocalDataSource` (Persistence using **Hive**)

> **Why use Dio instead of http?**
> - **More features**: Dio supports **interceptors, request cancellation, and automatic retries**.
> - **Better error handling**: It provides detailed error messages and stack traces.
> - **More flexibility**: Dio makes it easier to configure base options, authentication, and request transformations.

> **Why use Hive instead of SharedPreferences?**
> - **Better performance**: Hive is optimized for speed, even handling large datasets efficiently.
> - **Supports complex objects**: Unlike SharedPreferences, Hive can store entire objects with adapters.
> - **No need for serialization**: Hive automatically converts Dart objects into binary storage.

---

## Modularization

The application follows a **modular approach**, separating different features into self-contained modules. This ensures **better maintainability, scalability, and independent development**.

The project is split into the following modules:

- **`movies_module`**: Handles movie-related features (listings, details, etc.).
- **`favorites_module`**: Manages favorite movies, using a local database (**Hive**).
- **`shared_module`**: Contains common utilities, models, and shared logic.
- **`router_module`**: Manages app navigation using **AutoRoute**.

Each module:
- **Has its own dependencies** registered in a `locator.dart` file.
- **Exposes only necessary components** to avoid unnecessary coupling.
- **Can be developed independently** without affecting other modules.

> **Why modularization?**
> - **Scalability**: New features can be added as separate modules without impacting existing code.
> - **Independent development**: Teams can work on different modules simultaneously.
> - **Better organization**: Code is divided based on feature responsibilities.

---

## Navigation

The project uses **AutoRoute** for **declarative routing**, making navigation **type-safe and scalable**.

### Routes Overview:
- **`shared_module`**:
  - `/home`: Root page with **Bottom Navigation Bar**.
  - `/splash`: Initial loading screen.
- **`movies_module`**:
  - `/movies`: Movie listing screen.
  - `/movie/:id`: Movie details screen.
- **`favorites_module`**:
  - `/favorites`: List of favorite movies.

Navigation is managed through `router_module`, ensuring that **routing logic remains separate from UI components**.

> **Why use AutoRoute instead of Navigator 2.0 manually?**
> - **Simplifies deep linking**: Automatically parses URL parameters.
> - **Generates code**: Reduces boilerplate and ensures type safety.
> - **Improves navigation structure**: Keeps routes centralized and modular.

---

## Dependency Injection

The app uses **GetIt** for **dependency injection**, ensuring **loose coupling and easy dependency management**.

Each module registers its dependencies in a **locator file**, making it easy to initialize and manage objects.

### Example (`movies_module` locator):
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

> **Why** use **GetIt** for **DI?**
> - **Explicit** and predictable: **GetI** provides a clear way to register and retrieve dependencies.
> - **Simple** and lightweight: **No** additional complexity or learning curve.
> - **Works** well with modularization: **Dependencies** can be registered per module without conflicts.

## Running the Application
The application is **flavorized**, meaning it supports different environments (e.g., dev, prod). To run the app, execute one of the environment-specific main files:

```sh
flutter run -t lib/environments/main_dev.dart
```

or

```sh
flutter run -t lib/environments/main_prod.dart
```

> **Why use flavors?**
> - Allows different configurations for staging, production, or testing.
> - Separates API keys, logging levels, and feature flags per environment.
> - Improves security by keeping production and development settings distinct.

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