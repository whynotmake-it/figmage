JSON Token Source Spec (Lean)
Status: proposal

Overview
Figmage currently fetches variables/styles from the Figma API. This proposal adds
a JSON token source that can be produced by Figma plugins, while keeping the
existing generation pipeline and mode-aware output. The JSON format follows the
Design Tokens spec (`$type`, `$value`) and encodes modes as path segments.

Goals
- Enable offline generation from exported JSON tokens.
- Preserve Figmage's mode-aware output (light/dark, etc.).
- Minimize changes to existing generators and token filtering.
- Keep the Design Tokens file structure (no custom schema where possible).

Non-Goals
- Replacing the Figma API source or changing existing CLI defaults.
- Adding new token types beyond what Figmage already supports.
- Introducing a new alias syntax beyond Design Tokens curly-brace references.

JSON Format
Format: collection -> mode -> tokens (required)

Example:
{
  "ds": {
    "light": {
      "color1": { "$type": "color", "$value": "#d9d9d9" },
      "button": { "bg": { "$type": "color", "$value": "{ds.light.color1}" } }
    },
    "dark": {
      "color1": { "$type": "color", "$value": "#000000" }
    },
    "spacing": {
      "sm": { "$type": "number", "$value": 4 }
    }
  }
}

Rules
- Tokens are objects with `$value` and optional `$type` as per the Design Tokens
  spec.
- Groups are plain objects without `$value`.
- Modes are represented as the second path segment under a collection
  (e.g., `ds.light.color1`).

Mode Detection
- For token paths with 3+ segments, treat the second segment as a mode name
  only if there is at least one other sibling branch under the same collection
  whose token-name set matches (after removing the first two segments).
- If no matching sibling branch exists, the second segment is treated as part
  of the collection path (i.e. collectionName includes that segment), which
  results in a separate generated class.
- For token paths with 2 segments: first = collection, mode = "" (default),
  name = second segment.
- For token paths with 1 segment: collection = "" (top-level),
  mode = "" (default), name = segment.

Token Path Mapping
- A token path is the JSON key path.
- Example: `ds.light.colors.primary` maps to:
  - collectionName = `ds`
  - mode = `light`
  - token name = `colors/primary`
  - fullName = `ds/colors/primary`
- Example: `ds.light.spacing.sm` maps to:
  - collectionName = `ds/light` (when no matching `ds.dark.spacing.*` set exists)
  - mode = `""`
  - token name = `spacing/sm`
  - fullName = `ds/light/spacing/sm`
- Example: `ds.color` maps to:
  - collectionName = `ds`
  - mode = `""`
  - token name = `color`
  - fullName = `ds/color`
- Example: `color` maps to:
  - collectionName = `""`
  - mode = `""`
  - token name = `color`
  - fullName = `color`
- The resulting `DesignToken` is created with `valuesByModeName[mode]`.

Generated Class Example
Input tokens:
- `ds/dark/color1`
- `ds/light/color1`
- `ds/brand/brandColor`

Result:
- `ColorsDs` class with mode constructors (`dark`, `light`) and field `color1`
- `ColorsDsBrand` class (from collection `ds/brand`) with standard constructor
  and field `brandColor`

Aliases
- All values are fully resolved by the export plugin.
- The JSON source does not perform alias resolution.
- If multiple JSON files define the same token for the same mode, all tokens
  are kept and later suffixed by the generator per `doc/style-dedup.md`.

Types
- `$type` is required for JSON tokens to avoid guessing.
- Supported types are the same as existing Figmage generation:
  - color -> int
  - number -> double
  - boolean -> bool
  - text -> String
  - typography -> Typography model
  - boxShadow -> Design style model (if currently supported)

Config Additions (Lean)
Add an optional JSON source block:
json:
  paths:
    - example-token.json

Behavior:
- At least one source must be configured: `fileId` or `json.paths`.
- When `json.paths` is provided, JSON tokens are added alongside any Figma API
  tokens (if `fileId` is set).
- `fileId` and `token` are optional when `json.paths` is provided.
- `dropUnresolved` is applied to the merged token list; JSON tokens should
  always be resolvable and therefore remain unaffected.
- Duplicate handling follows `doc/style-dedup.md` conventions (suffixing to keep
  all tokens).

Implementation Sketch
- Add `JsonTokensRepository` that parses the JSON file into a list of
  `DesignToken<T>` instances with `valuesByModeName` populated.
- Add a `jsonTokensProvider` and merge JSON tokens when
  `config.json.paths` is set.
- Keep generators unchanged by emitting the same `DesignToken` interface.

Implementation Plan
1) Config wiring
- Add a JSON source field to `Config` in `lib/src/domain/models/config/config.dart`.
- Regenerate serialization in `lib/src/domain/models/config/config.g.dart`.
- Update `lib/src/data/repositories/yaml_config_repository.dart` to accept the
  new config block without custom parsing (still via `Config.fromMap`).

2) JSON token model
- Add a lightweight token model that implements `DesignToken<T>` and stores:
  `collectionName`, `collectionId`, `fullName`, `valuesByModeName`.
  Suggested location: `lib/src/domain/models/json_token.dart`.

3) JSON parsing repository
- Add repository interface in `lib/src/domain/repositories/json_tokens_repository.dart`.
- Implement in `lib/src/data/repositories/json_tokens_repository.dart`.
  - Parse tokens by walking the JSON object tree:
  - Identify tokens by presence of `$value`.
  - Compute path segments and map:
    - 3+ segments: first = collection, second = mode only when matched by a
      sibling branch with the same token-name set; otherwise treat second as
      part of the collection path.
    - 2 segments: first = collection, mode = "", name = second.
    - 1 segment: collection = "", mode = "", name = segment.
  - Build `fullName = collection/name` (omit slash if collection is empty).
  - Group tokens by `(collectionName, name, type)` and merge into
    `valuesByModeName` by mode.
  - Token-name set is computed per (collection, candidate mode) branch by
    collecting the relative token names below that branch and comparing sets
    across sibling branches under the same collection.
- Convert `$type` values into the existing domain types:
  - color -> int (hex parsing utility in a new helper, e.g.
    `lib/src/data/util/converters/hex_color_conversion_x.dart`)
  - number -> double, boolean -> bool, text -> String
  - typography -> `Typography` via existing model

4) Provider integration
- Add a `jsonTokensProvider` in `lib/src/domain/providers/design_token_providers.dart`.
- Update `filteredTokensProvider` in `lib/src/domain/providers/design_token_providers.dart`
  to merge JSON tokens (from `config.json.paths`) with Figma tokens
  (when `config.fileId` is set).

Validation & Errors
- Fail fast if any `json.paths` entry is unreadable or invalid JSON.

Compatibility
- This format stays within the Design Tokens file structure.
- Existing Figma API flow remains untouched unless JSON source is configured.
