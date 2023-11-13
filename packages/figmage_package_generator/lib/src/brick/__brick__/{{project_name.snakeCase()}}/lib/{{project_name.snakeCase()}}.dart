/// {{{description}}}
library {{project_name.snakeCase()}};

{{#generate_bools}}export 'src/bools.dart';{{/generate_bools}}
{{#generate_colors}}export 'src/colors.dart';{{/generate_colors}}
{{#generate_paddings}}export 'src/paddings.dart';{{/generate_paddings}}
{{#generate_radii}}export 'src/radii.dart';{{/generate_radii}}
{{#generate_spacers}}export 'src/spacers.dart';{{/generate_spacers}}
{{#generate_strings}}export 'src/strings.dart';{{/generate_strings}}
{{#generate_typography}}export 'src/typography.dart';{{/generate_typography}}
