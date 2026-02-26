# 待办事项应用 - Todo Flutter Clean Architecture

![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)
![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)
![Architecture](https://img.shields.io/badge/Architecture-Clean-red.svg)

A modern Flutter todo application demonstrating clean architecture principles with reactive state management using Isar database and GetIt dependency injection.

## Screenshots

### Projects Screen
![Projects Screen](screenshots/projects_screen.png)

### Todo Details Screen
![Todo Details Screen](screenshots/todo_details_screen.png)

## Overview

This project showcases a production-ready Flutter application with:
- **Clean Architecture** - separation of concerns with Repository pattern
- **Dependency Injection** - GetIt service locator for dependency management
- **Reactive Streams** - real-time UI updates using Isar's built-in watch functionality
- **Provider Pattern** - efficient state management with ChangeNotifier
- **Isar Database** - high-performance local storage with type safety
- **GoRouter** - type-safe navigation

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│                   Presentation Layer                     │
│  (Pages, Widgets, UI Components)                         │
└────────────────────┬────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────┐
│                   Provider Layer                         │
│  (ProjectProvider, TodoProvider - State Management)      │
└────────────────────┬────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────┐
│                  Domain Layer                            │
│  (Repositories, Entities, Business Logic)                │
└────────────────────┬────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────┐
│                   Data Layer                             │
│  (Repository Implementation, Isar Database)              │
└─────────────────────────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────┐
│              Dependency Injection Layer                   │
│  (GetIt Service Locator - Singleton Management)          │
└─────────────────────────────────────────────────────────┘
```

## Tech Stack

- **Framework**: Flutter
- **Language**: Dart 3.0+
- **State Management**: Provider 6.1.5
- **Dependency Injection**: GetIt 7.6.0
- **Database**: Isar Community (NoSQL with type safety)
- **Routing**: GoRouter 17.1.0
- **Architecture**: Clean Architecture + Repository Pattern

## Key Features

### Reactive State Management
- Real-time updates using Isar streams
- Automatic UI rebuilds on data changes
- Memory efficient with proper subscription management
- Reactive with focus on single responsibility

### Dependency Injection
- GetIt service locator for centralized dependency management
- Single instance of database across app
- Clean separation of concerns with providers and repositories

### Project & Todo Management
- Create, read, update, delete projects
- Organize todos within projects
- Track completion status with visual distinction
- Split view for pending and completed todos
- IsarLinks for type-safe relationships

### Clean Separation of Concerns
- **Domain Layer**: Abstract repositories and business entities
- **Data Layer**: Repository implementations with Isar integration
- **Presentation Layer**: UI components with Provider integration
- **Service Locator**: GetIt for dependency injection

### User Interface
- Material Design 3
- Split screen view (待办事项 on top, 已完成 on bottom)
- Smooth keyboard handling with SingleChildScrollView
- Modal bottom sheets for create/edit dialogs
- Focus management for better UX

## Project Structure

```
lib/
├── core/
│   ├── di/                     # Dependency Injection
│   │   └── service_locator.dart
│   └── theme/
│       └── app_theme.dart
├── domain/
│   ├── entity/                 # Business entities
│   │   ├── project_entity.dart
│   │   └── todo_entity.dart
│   └── repositories/           # Abstract interfaces
│       ├── project_repository.dart
│       └── todo_repository.dart
├── data/
│   └── repository/             # Concrete implementations
│       ├── project_repository_impl.dart
│       └── todo_repository_impl.dart
├── provider/                   # State management
│   ├── app_initializer.dart    # Database initialization
│   ├── project_provider.dart
│   └── todo_provider.dart
├── pages/
│   ├── projects/               # Project screens
│   │   ├── projects_page.dart
│   │   └── widgets/
│   │       ├── create_project_sheet.dart
│   │       └── project_tile.dart
│   └── todos/                  # Todo screens
│       ├── todos_page.dart
│       └── widgets/
│           ├── create_todo_sheet.dart
│           └── todo_tile.dart
├── router/                     # Navigation
│   └── app_router.dart
└── main.dart
```

## Getting Started

### Prerequisites
- Flutter 3.0+
- Dart 3.0+

### Installation

1. Clone the repository
```bash
git clone https://github.com/teasec4/todo-flutter-clean.git
cd todo-flutter-clean
```

2. Install dependencies
```bash
flutter pub get
```

3. Generate Isar database models
```bash
dart run build_runner build
```

4. Run the app
```bash
flutter run
```

## Data Flow

### Create Project Flow
```
UI (CreateProjectSheet)
    ↓
ProjectProvider.createProject()
    ↓
ProjectRepository.createProject()
    ↓
Isar.writeTxn() [Database Update]
    ↓
Stream.watchProjects() [Triggers Update]
    ↓
ProjectProvider [notifyListeners()]
    ↓
UI Rebuilds [ProjectsPage Updated]
```

### Create Todo Flow
```
UI (CreateTodoSheet)
    ↓
TodoProvider.createTodo()
    ↓
TodoRepository.addTodo()
    ↓
Isar.writeTxn() [Database Update]
    ↓
Stream.watchAllTodos() [Triggers Update]
    ↓
TodoProvider [notifyListeners()]
    ↓
UI Rebuilds [TodosPage Split View Updated]
```

## Dependency Injection Flow

```
main.dart
    ↓
AppInitializer.init() [Initialize Isar]
    ↓
setupServiceLocator(isar) [Register in GetIt]
    ↓
MyApp [Wrap with MultiProvider]
    ↓
ChangeNotifierProvider.value() [getIt<ProjectProvider>()]
ChangeNotifierProvider.value() [getIt<TodoProvider>()]
    ↓
Pages can use context.watch() or context.read()
```

## Key Concepts

### Reactive Streams
- Database changes trigger automatic UI updates
- No manual state refresh needed
- Efficient resource management with subscription cleanup
- Isar's watch functionality provides real-time synchronization

### IsarLinks
- Type-safe relationships between entities
- Bidirectional sync between collections
- Automatic persistence of relationships
- One-to-many relationship between Projects and Todos

### Provider Pattern
- Centralized state management via ChangeNotifier
- Automatic disposal of resources
- Clean separation from UI logic
- Works seamlessly with GetIt for dependency injection

### GetIt Service Locator
- Single instance management for database
- Singleton pattern for repositories and providers
- Clean initialization flow in main()
- Testable architecture with easy mocking

### State Management Architecture
- AppInitializer manages database lifecycle and loading states
- ProjectProvider and TodoProvider handle business logic
- Repositories abstract data access
- UI consumes state via Provider.watch() and Provider.read()

## UI Features

### Split View Layout
- Top half: Pending todos (待办事项)
- Bottom half: Completed todos (已完成)
- Automatic sorting and filtering
- Smooth transitions and visual feedback

### Keyboard Handling
- SingleChildScrollView for responsive modal dialogs
- FocusNode management for smooth field transitions
- MediaQuery.viewInsets.bottom for keyboard avoidance
- TextInputAction for better mobile UX

### Focus Management
- Auto-focus on first field when modal opens
- Smooth transition between fields
- Proper focus cleanup on dispose

## Dependencies

Key packages:
- `provider: ^6.1.5+1` - State management
- `get_it: ^7.6.0` - Service locator/DI
- `isar_community: ^3.3.0` - Database
- `go_router: ^17.1.0` - Navigation
- `path_provider: ^2.1.5` - File system access

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Author

Created as a demonstration of clean architecture principles in Flutter with modern dependency injection patterns.
