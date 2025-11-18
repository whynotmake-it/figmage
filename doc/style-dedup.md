# Style Dedup Challenges

## Why duplicates happen
- Figma’s REST styles endpoints (`/v1/files/:file_key/styles`, `/v1/teams/:team_id/styles`, etc.) return `key`, `file_key`, `node_id`, `style_type`, `name`, `description`, timestamps, and `sort_position`. There is **no** `collectionId` concept for styles; the “Headline/Headline 2” grouping you see in the UI is simply encoded in the `name` string via slash naming or folders.
- Designers can create multiple published styles that share the exact same `name` (path) inside the same file or library. When Figmage groups styles by `name` to generate strongly typed classes, every later style would overwrite the earlier one unless we intervene.
- The API doesn’t tell us which duplicate is “authoritative.” We can only distinguish them by IDs or timestamps (e.g., `key`, `node_id`, `created_at`), so deduping requires extra configuration or heuristics that Figmage doesn’t currently have.

## Current Figmage strategy
- We keep **all** occurrences. While building `valuesByNameByMode`, duplicate style names receive deterministic suffixes (`Variant2`, `Variant3`, …) so map keys stay unique.
- The code generators also sanitize identifiers; if two already-suffixed names still collide after camel-casing, the generator appends another suffix. That’s how extreme cases produced names like `display1Variant2Variant2`—one suffix came from the token map, another from the generator’s collision guard.
- Users get a warning listing every duplicate style (with node IDs) so they can clean up the design file or expect suffixed members in the generated Dart code.

## Key takeaways
- Styles don’t have collections in the REST API; only variables have `variableCollectionId`. Figmage infers “collections” from the slash-separated `name`.
- Duplicate warnings mean “Figmage kept every copy and suffixed the Dart members,” not that we can tell which one is canonical.
- To truly pick one style out of a set of duplicates, we would need extra rules (designer config, allowlists, or heuristics using `key`, `created_at`, etc.). Until then, suffixing keeps generated code consistent without silently dropping tokens.*** End Patch*** End Patch
