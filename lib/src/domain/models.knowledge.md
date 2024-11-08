```markdown
# Models

## Refactoring Guidelines

### Simplification
- Prefer flat structures over nested ones (e.g., direct node-to-asset mapping instead of groups)
- When refactoring models, ensure all references are updated:
  1. The model itself
  2. Associated tests
  3. Generators using the model
  4. Documentation
  5. YAML configuration examples

### Testing
- Always update both unit tests and integration tests when changing models
- Test files should mirror the simplified structure in their examples

## Architecture Patterns

### Generators
- All generators must be integrated through generator_providers.dart
- Never implement generation logic directly in commands
- Follow the pattern:
  1. Create generator class implementing FileGenerator
  2. Add to generator_providers.dart
  3. Let library_provider handle file generation
```
