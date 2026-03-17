# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Widget Rules

**Use class-based widgets (recommended):**
```dart
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```

**Do NOT use functional components:**
```dart
// BAD - Do not use this pattern
Widget buildHome() {
  return Container();
}
```

## Commands

```bash
# Run the app
flutter run

# Analyze code
flutter analyze

# Run tests
flutter test

# Run single test file
flutter test test/widget_test.dart
```

## Architecture

This is a Flutter BLoC pattern example app with layered structure:

```
lib/
├── main.dart           # App entry point, theme config, BlocObserver
├── bloc/               # Business logic layer
│   └── cart/
│       ├── cart_bloc.dart
│       ├── cart_event.dart
│       └── cart_state.dart
└── ui/                 # Presentation layer
    └── cart/
        ├── cart_page.dart   # BlocProvider wrapper
        └── cart_view.dart   # UI widgets
```

**BLoC Pattern Convention:**
- `*_page.dart`: Wraps view with `BlocProvider`
- `*_view.dart`: Contains UI, uses `BlocBuilder` to consume state
- `*_bloc.dart`: Handles events and emits state
- `*_event.dart`: `sealed class` event definitions
- `*_state.dart`: Immutable state with `copyWith`

**State Management:**
- Uses `flutter_bloc` package
- Simple architecture without Repository layer (suitable for small apps)
- `AppBlocObserver` in main.dart logs all state transitions
