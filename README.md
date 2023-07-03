# Flutter Riverpod Pokedex

This application is developed with Flutter, it consumed the API RESTful [PokeApi](https://pokeapi.co/). This application is intended to be an example of Clean Architecture, Unit Test, Widget Test and Integration test. Watch a demo [here](https://cruznestor.github.io/flutter_riverpod_pokedex_page/).

## Dependencies

- [dio](https://pub.dev/packages/dio) - A powerful HTTP client for Dart/Flutter, which supports global configuration, interceptors, FormData, request cancellation, file uploading/downloading, timeout, and custom adapters etc.
- [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) - A simple way to access state from anywhere in your application while robust and testable.
- [freezed_annotation](https://pub.dev/packages/freezed_annotation) - Annotations for the freezed code-generator. This package does nothing without `freezed` too.
- [go_router](https://pub.dev/packages/go_router) - A declarative router for Flutter based on Navigation 2 supporting deep linking, data-driven routes and more.
- [intl](https://pub.dev/packages/intl) - Contains code to deal with internationalized/localized messages, date and number formatting and parsing, bi-directional text, and other internationalization issues.
- [json_annotation](https://pub.dev/packages/json_annotation) - Classes and helper functions that support JSON code generation via the `json_serializable` package.
- [path](https://pub.dev/packages/path) - The path package provides common operations for manipulating paths: joining, splitting, normalizing, etc.
- [sliver_tools](https://pub.dev/packages/sliver_tools) - A set of useful sliver tools that are missing from the flutter framework.
- [transparent_image](https://pub.dev/packages/transparent_image) - A simple transparent image. Represented as a Uint8List, which was originally extracted from the Flutter codebase.

## Development Dependencies

- [build_runner](https://pub.dev/packages/build_runner) - A build system for Dart code generation and modular compilation.
- [freezed](https://pub.dev/packages/freezed) - Code generation for immutable classes that has a simple syntax/API without compromising on the features.
- [integration_test](https://github.com/flutter/flutter/tree/main/packages/integration_test) - This package enables self-driving testing of Flutter code on devices and emulators.
- [json_serializable](https://pub.dev/packages/json_serializable) - Automatically generate code for converting to and from JSON by annotating Dart classes.
- [mocktail](https://pub.dev/packages/mocktail) - Mocktail focuses on providing a familiar, simple API for creating mocks in Dart (with null-safety) without the need for manual mocks or code generation.
- [network_image_mock](https://pub.dev/packages/network_image_mock) - A utility for providing mocked response to Image.network in Flutter widget tests.

## Features

- **Generation**: Show all pokémon generations.
- **Pokemon Detail**: Shows basic information about the selected pokemon.
- **Search Pokemon**: Allows the query of pokémon by name or id.