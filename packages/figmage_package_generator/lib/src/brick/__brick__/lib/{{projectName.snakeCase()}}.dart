/// {{{description}}}
library {{projectName.snakeCase()}};

{{#generateBools}}export 'src/bools.dart';{{/generateBools}}
{{#generateColors}}export 'src/colors.dart';{{/generateColors}}
{{#generateNumbers}}export 'src/numbers.dart';{{/generateNumbers}}
{{#generatePaddings}}export 'src/paddings.dart';{{/generatePaddings}}
{{#generateRadii}}export 'src/radii.dart';{{/generateRadii}}
{{#generateSpacers}}export 'src/spacers.dart';{{/generateSpacers}}
{{#generateStrings}}export 'src/strings.dart';{{/generateStrings}}
{{#generateTypography}}export 'src/typography.dart';{{/generateTypography}}
{{#generateAssets}}export 'src/assets.dart';{{/generateAssets}}
