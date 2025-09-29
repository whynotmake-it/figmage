# Agent Guidelines for Figmage

## Build/Test Commands
- **Test all**: `melos run test` or `dart test` (in root/packages)
- **Test single file**: `dart test test/path/to/test_file.dart`
- **Analyze**: `melos run analyze` or `dart analyze . --fatal-infos`
- **Generate code**: `melos run generate` (runs build_runner)
- **Coverage**: `melos run coverage`

## Code Style
- Uses **lintervention** linting rules (see analysis_options.yaml)
- **Imports**: External packages first, then local imports with relative paths
- **Naming**: snake_case for files/directories, camelCase for variables, PascalCase for classes
- **Types**: Use explicit types for public APIs, prefer `final` over `var`
- **Documentation**: Use `/// {@template}` blocks for class documentation
- **Error handling**: Use Result types or throw specific exceptions
- **State management**: Uses Riverpod providers consistently
- **Testing**: Use mocktail for mocking, group tests logically
- **Code generation**: Use freezed for data classes, json_serializable for JSON
- **File structure**: Group by feature (commands/, data/, domain/)

## Key Patterns
- Provider-based dependency injection with Riverpod
- Freezed unions for variant types (e.g., AliasOr<T>)
- Repository pattern for data access
- Command pattern for CLI operations