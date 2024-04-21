# Figmage

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)
[![melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos)
![Coverage Badge](./coverage-total.svg)

A CLI tool for generating Figma styles for Flutter

## Installation 💻

**❗ In order to start using Figmage you must have the [Dart SDK][dart_install_link] installed on your machine.**

Install via `dart pub add`:

```sh
dart pub add figmage
```

## How to generate 🏭

#### 🚀 Quick start

This command will generate a new package at the specified output path using the provided Figma API token and file ID:

```sh
figmage forge <path> --token <token> --fileId <fileId>
```

> [!info] > **🤔 Wait, what's a token? And what's this fileId? Where do I get them?**
>
> To interact with the Figma API, you'll need an **access token**. Check out the [Figma Docs](https://www.figma.com/developers/api#access-tokens) to learn how to create yours.
>
> The **fileId** is part of the URL when you open a Figma file. Just look in your browser's address bar when you have your design system file open:<br>
> ➡ figma.com/file/**your-file-id-is-here**/more-not-so-interesting-stuff

#### 🎨 Details

If you require more control over the generated code, create a `figmage.yaml` file in the directory from which you're running the command. Below is an example, along with descriptions of what each flag accomplishes:

```yaml
# Default: "figmage_package". The name of the generated Dart package.
packageName: "figmage_package"
# Required. The Figma file ID from which to generate tokens.
fileId: "YOUR_FIGMA_FILE_ID"
# Default: ''. Description of the generated package.
packageDescription: "A package generated from Figma designs."
# Default: '.'. Directory to generate the package in, relative to this config file.
packageDir: "./generated"
# Default: true. Determines whether to drop unresolvable values. When true, values that cannot be resolved (e.g., an alias pointing to a missing variable) are omitted, ensuring all tokens are resolvable in all modes (e.g., light and dark mode). When false, unresolved variables are included but will return null. Defaults to false.
dropUnresolved: true
colors:
  # Default: true. Whether to generate color tokens.
  generate: true
  # Default: []. Specific paths to generate color tokens from.
  from:
    - "colors/path"
typography:
  # Default: true. Whether to generate typography tokens.
  generate: true
  # Default: []. Specific paths to generate typography tokens from.
  from:
    - "typography/path"
  # Default: true. Whether to use Google Fonts for font families.
  useGoogleFonts: true
numbers:
  # Default: false. Whether to generate number tokens (for spacers, paddings, borders).
  generate: false
  # Default: []. Specific paths to generate number tokens from.
  from:
    - "numbers/path"
spacers:
  # Default: false. Whether to generate spacer tokens.
  generate: false
  # Default: []. Specific paths to generate spacer tokens from.
  from:
    - "spacers/path"
paddings:
  # Default: false. Whether to generate padding tokens.
  generate: false
  # Default: []. Specific paths to generate padding tokens from.
  from:
    - "paddings/path"
```

## How to use 📲

#### 🚀 Quick start

To integrate your newly minted token package into your app, simply add it to your `pubspec.yaml` file:

```yaml
figmage_package:
  path: path/to/your/package
```

Incorporate design tokens into your code as follows:

```dart
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        extensions: <ThemeExtension<dynamic>>[
          ColorsDesignSystem.dark(), // <- added
          TypographyDesignSystem.standard(), // <- added
        ],
      ),
      darkTheme: ThemeData.dark().copyWith(
        extensions: <ThemeExtension<dynamic>>[
          ColorsDesignSystem.dark(), // <- added
          TypographyDesignSystem.standard(), // <- added
        ],
      ),
      themeMode: isLightTheme ? ThemeMode.light : ThemeMode.dark,
      home: Home(
        isLightTheme: isLightTheme,
        toggleTheme: toggleTheme,
      ),
    );
  }
```

Leverage the tokens within your widgets like so:

```dart
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorsDesignSystem;
    final typography = context.typographyDesignSystem;

    return Container(
        color: colors.primary,
        child: Text('Hello world!', style: typography.body1),
    )
    ...
```

#### 🎨 Details

The design tokens are wrapped into classes. The grouping depends on the collection for variable based tokens and on the style group name for style based tokens. Each class implements `BuildContext`extension which can be used to propergate the design tokens through your app.

## Continuous Integration 🤖

Figmage comes with a built-in [GitHub Actions workflow][github_actions_link] but you can also add your preferred CI/CD solution.

## This project includes [Melos](https://github.com/invertase/melos).

[dart_install_link]: https://dart.dev/get-dart
[github_actions_link]: https://docs.github.com/en/actions/learn-github-actions
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[mason_link]: https://github.com/felangel/mason
[very_good_ventures_link]: https://verygood.ventures
