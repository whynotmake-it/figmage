## 0.1.0-dev.13

 - **FIX**: correctly fetch opacity for color styles (#175).
 - **FEAT**: allow configuring the path under `lib/` where tokens are generated (#176).
 - **FEAT**: allow for using figmage to generate styles for your existing app (#174).
 - **FEAT**: pull assets from Figma (#162).
 - **DOCS**: added guides for the new features and updated the theme (#181).

## 0.1.0-dev.12

 - **DOCS**: added documentation website (#159).

## 0.1.0-dev.11

 - **DOCS**: update README to clarify Figma file ID usage and command syntax (#155).

## 0.1.0-dev.10

 - **FIX**: the package name is now created correctly even when no `--path` flag is passed (#151).

## 0.1.0-dev.9

> Note: This release has breaking changes.

 - **FIX**: typos in several log messages (#141).
 - **BREAKING** **FEAT**: if no `packageName` is provided in figmage.yaml, use the current directory's name as default. (#143).

## 0.1.0-dev.8

> Note: This release has breaking changes.

 - **FIX**: improve logging when no styles were found.
 - **FIX**: improved error message when the user wasn't authorized to fetch variables.
 - **FIX**: `google_fonts` import and generated file preamble (#129).
 - **FEAT**(figma_variables_api): enable fetching local styles from file.
 - **FEAT**(figma_variables_api): support file endpoint.
 - **DOCS**: added new `stylesFromLibrary` config parameter to README.
 - **BREAKING** **FEAT**: styles are now fetched locally from the given file by default.

## 0.1.0-dev.7

 - **FIX**: remove `packageDir` from figmage.yaml, the package will always be generated in the directory where you put the figmage.yaml.

## 0.1.0-dev.6

 - **FIX**: naming for style tokens (#113).

## 0.1.0-dev.5

> Note: This release has breaking changes.

 - **BREAKING** **FEAT**: other characters in Figma token names are converted into proper camel case paths. (#105).

## 0.1.0-dev.4

 - **FIX**: styles import is not handled by `package:figma` anymore (#96).
 - **FIX**: null return type in padding generator (#89).

## 0.1.0-dev.3

> Note: This release has breaking changes.

 - **REVERT**: chore: coverage badges [skip ci].
 - **FIX**: generator tries to fit all variable collections into one class (#42).
 - **FIX**: no export for `typography.dart` (#41).
 - **FIX**: update coverage generation (#39).
 - **FEAT**: remove reforge (#69).
 - **FEAT**: nullable field types if unresolved (#64).
 - **FEAT**: handle unresolved variables (#63).
 - **FEAT**: file generators (#61).
 - **FEAT**: support for google fonts package (#28).
 - **FEAT**: paddings generator (#24).
 - **FEAT**: forge command testable, added test (#16).
 - **FEAT**: spacer generator (#21).
 - **FEAT**: added number generator, added BuildContext extension to ThemeExtensionGenerator (#18).
 - **FEAT**: config yaml repository (#17).
 - **FEAT**: universal extension generator (#13).
 - **FEAT**: variables repo & model & convert aliases (#9).
 - **FEAT**: figma_package_generator (#5).
 - **FEAT**: basic architecture (#4).
 - **FEAT**: api setup (#3).
 - **FEAT**: initial project setup (#2).
 - **FEAT**: initial commit.
 - **DOCS**: fix info box again (#75).
 - **DOCS**: fix README note (#74).
 - **DOCS**: finalize documentation (#70).
 - **DOCS**: usage readme (#67).
 - **DOCS**: README Introduction (#66).
 - **BREAKING** **REFACTOR**: unify `SpacersGenerator` and `PaddingsGenerator` in `ReferenceThemeClassGenerator` (#59).
 - **BREAKING** **FEAT**: connect everything together (#25).
 - **BREAKING** **FEAT**(figmage_package_generator): added files per type (#8).

## 0.1.0-dev.2

> Note: This release has breaking changes.

 - **REVERT**: chore: coverage badges [skip ci].
 - **FIX**: generator tries to fit all variable collections into one class (#42).
 - **FIX**: no export for `typography.dart` (#41).
 - **FIX**: update coverage generation (#39).
 - **FEAT**: remove reforge (#69).
 - **FEAT**: nullable field types if unresolved (#64).
 - **FEAT**: handle unresolved variables (#63).
 - **FEAT**: file generators (#61).
 - **FEAT**: support for google fonts package (#28).
 - **FEAT**: paddings generator (#24).
 - **FEAT**: forge command testable, added test (#16).
 - **FEAT**: spacer generator (#21).
 - **FEAT**: added number generator, added BuildContext extension to ThemeExtensionGenerator (#18).
 - **FEAT**: config yaml repository (#17).
 - **FEAT**: universal extension generator (#13).
 - **FEAT**: variables repo & model & convert aliases (#9).
 - **FEAT**: figma_package_generator (#5).
 - **FEAT**: basic architecture (#4).
 - **FEAT**: api setup (#3).
 - **FEAT**: initial project setup (#2).
 - **FEAT**: initial commit.
 - **DOCS**: fix info box again (#75).
 - **DOCS**: fix README note (#74).
 - **DOCS**: finalize documentation (#70).
 - **DOCS**: usage readme (#67).
 - **DOCS**: README Introduction (#66).
 - **BREAKING** **REFACTOR**: unify `SpacersGenerator` and `PaddingsGenerator` in `ReferenceThemeClassGenerator` (#59).
 - **BREAKING** **FEAT**: connect everything together (#25).
 - **BREAKING** **FEAT**(figmage_package_generator): added files per type (#8).

## 0.1.0+1

- feat: initial commit 🎉
