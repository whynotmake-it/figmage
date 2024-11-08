# Design Principles

## Simplicity First
- Prefer simple, convention-based solutions over complex abstractions
- Use filename conventions over class hierarchies where possible
- Example: Asset scaling uses filename suffix (@2x.png) instead of configuration objects

## File Naming Conventions
- Asset scale indicators go in filename: `name@2x.png`
- Keep filenames lowercase with underscores
- Use descriptive, purpose-indicating names

## Code Generation
- Generate minimal, focused code
- Avoid creating abstractions that could be solved with conventions
- When in doubt, generate less code
