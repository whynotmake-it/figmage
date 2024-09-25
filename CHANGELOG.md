## 0.1.0-dev.9

> Note: This release has breaking changes.

 - **REVERT**: chore: coverage badges [skip ci].
 - **FIX**: update coverage generation (#39).
 - **FIX**: improve logging when no styles were found.
 - **FIX**: improved error message when the user wasn't authorized to fetch variables.
 - **FIX**: `google_fonts` import and generated file preamble (#129).
 - **FIX**: remove `packageDir` from figmage.yaml, the package will always be generated in the directory where you put the figmage.yaml.
 - **FIX**: naming for style tokens (#113).
 - **FIX**: styles import is not handled by `package:figma` anymore (#96).
 - **FIX**: null return type in padding generator (#89).
 - **FIX**: generator tries to fit all variable collections into one class (#42).
 - **FIX**: no export for `typography.dart` (#41).
 - **FEAT**: handle unresolved variables (#63).
 - **FEAT**: silient for happy case (#79).
 - **FEAT**: basic architecture (#4).
 - **FEAT**: figma_package_generator (#5).
 - **FEAT**: variables repo & model & convert aliases (#9).
 - **FEAT**: remove reforge (#69).
 - **FEAT**: config yaml repository (#17).
 - **FEAT**: added number generator, added BuildContext extension to ThemeExtensionGenerator (#18).
 - **FEAT**: nullable field types if unresolved (#64).
 - **FEAT**: support for google fonts package (#28).
 - **FEAT**: file generators (#61).
 - **FEAT**: spacer generator (#21).
 - **FEAT**(figma_variables_api): support file endpoint.
 - **FEAT**: api setup (#3).
 - **FEAT**: initial project setup (#2).
 - **FEAT**(figma_variables_api): enable fetching local styles from file.
 - **FEAT**: initial commit.
 - **FEAT**: forge command testable, added test (#16).
 - **FEAT**: paddings generator (#24).
 - **FEAT**: universal extension generator (#13).
 - **DOCS**: README Introduction (#66).
 - **DOCS**: usage readme (#67).
 - **DOCS**: fix info box again (#75).
 - **DOCS**: finalize documentation (#70).
 - **DOCS**: fix README note (#74).
 - **DOCS**: added new `stylesFromLibrary` config parameter to README.
 - **BREAKING** **REFACTOR**: unify `SpacersGenerator` and `PaddingsGenerator` in `ReferenceThemeClassGenerator` (#59).
 - **BREAKING** **FEAT**(figmage_package_generator): added files per type (#8).
 - **BREAKING** **FEAT**: other characters in Figma token names are converted into proper camel case paths. (#105).
 - **BREAKING** **FEAT**: styles are now fetched locally from the given file by default.
 - **BREAKING** **FEAT**: connect everything together (#25).

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
