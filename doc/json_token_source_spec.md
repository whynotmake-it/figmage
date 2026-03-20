JSON Token Source Spec
Status: implemented

Overview
Figmage supports JSON token ingestion via a resolver-manifest entrypoint.
JSON source data is merged with Figma API tokens (if configured) and uses the
same downstream generation pipeline.

Resolver Entrypoint
`json.paths` must contain exactly one file path, and that path must point to a
resolver manifest JSON file.

Resolver format (required fields):
- `version`: non-empty string (currently minimally validated)
- `sets`: object where each key is a set name and each value is an object with
  `"$ref": "./some-file.json"`
- `resolutionOrder`: non-empty list of set names

Example:
```json
{
  "version": "2025.10",
  "sets": {
    "global": { "$ref": "./global.json" },
    "Color Primitives": { "$ref": "./Color Primitives.json" },
    "Color Aliases": { "$ref": "./Color Aliases.json" }
  },
  "resolutionOrder": ["global", "Color Primitives", "Color Aliases"]
}
```

Validation
Figmage throws when:
- `json.paths` does not contain exactly one path
- resolver file is missing or invalid JSON
- resolver shape is invalid (`version`/`sets`/`resolutionOrder`)
- `resolutionOrder` references a set not present in `sets`
- resolver set file path is missing/unreadable
- the resolver references the same resolved set file path more than once

Token Parsing
- Token objects must include `$type` and `$value`.
- Supported `$type` values:
  - `color` -> `int`
  - `number` -> `double`
  - `boolean` -> `bool`
  - `text` -> `String`
  - `typography` -> `Typography`
- Mode inference remains path-based (same behavior as previous JSON mode):
  second segment can become mode when branch signatures match.

Reference Resolution
Figmage uses a two-pass pipeline:
1. Parse all resolver-ordered set files and collect token definitions.
2. Resolve aliases/refs and emit `AliasOr` structures.

Supported references:
- Curly alias: `"{Color Primitives.Value.stone.50}"`
  - Resolves against the resolver-expanded virtual token graph across all files
    in `resolutionOrder`.
  - Dot-separated segments map to JSON key path segments.
  - If no match exists, value becomes unresolved and a diagnostic is emitted.
  - If multiple matches exist, value becomes unresolved and an ambiguity
    diagnostic is emitted.
- Cross-file `$ref` inside `$value`:
  - `"$value": { "$ref": "./Color Primitives.json#/Value/stone/50" }`
  - Relative file paths resolve from the resolver manifest directory.
  - Empty file part (for example `#/Color Primitives/Value/stone/50`) resolves
    in the current file.
  - JSON Pointer syntax is supported and validated.
  - Pointer targets are validated by usage context:
    - direct token object pointers resolve
    - token `$value` pointers resolve to the owning token alias
    - non-token targets become unresolved with diagnostics

Failure Behavior
Reference failures do not abort JSON ingestion. Instead, Figmage:
- emits diagnostics through repository diagnostics callback
- marks the value as unresolved (`AliasOr.unresolved`)

This includes:
- missing target
- invalid pointer
- target not a token object
- type mismatch
- cyclic references
- malformed alias/ref syntax

Interaction with `dropUnresolved`
- `dropUnresolved: true` removes tokens that have unresolved values in any mode.
- `dropUnresolved: false` keeps tokens; unresolved values resolve to `null`.

Non-Goals (current scope)
- Resolver `modifiers` / runtime context selection
- Full Resolver-module execution semantics beyond ordered set expansion
