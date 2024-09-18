// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map json) => $checkedCreate(
      'Config',
      json,
      ($checkedConvert) {
        final val = Config(
          packageName: $checkedConvert(
              'packageName', (v) => v as String? ?? "figmage_package"),
          fileId: $checkedConvert('fileId', (v) => v as String?),
          packageDescription:
              $checkedConvert('packageDescription', (v) => v as String? ?? ''),
          dropUnresolved:
              $checkedConvert('dropUnresolved', (v) => v as bool? ?? false),
          stylesFromLibrary:
              $checkedConvert('stylesFromLibrary', (v) => v as bool? ?? false),
          colors: $checkedConvert(
              'colors',
              (v) => v == null
                  ? const GenerationSettings()
                  : GenerationSettings.fromJson(v as Map)),
          typography: $checkedConvert(
              'typography',
              (v) => v == null
                  ? const TypographyGenerationSettings()
                  : TypographyGenerationSettings.fromJson(v as Map)),
          strings: $checkedConvert(
              'strings',
              (v) => v == null
                  ? const GenerationSettings()
                  : GenerationSettings.fromJson(v as Map)),
          bools: $checkedConvert(
              'bools',
              (v) => v == null
                  ? const GenerationSettings()
                  : GenerationSettings.fromJson(v as Map)),
          numbers: $checkedConvert(
              'numbers',
              (v) => v == null
                  ? const GenerationSettings()
                  : GenerationSettings.fromJson(v as Map)),
          spacers: $checkedConvert(
              'spacers',
              (v) => v == null
                  ? const GenerationSettings(generate: false)
                  : GenerationSettings.fromJson(v as Map)),
          paddings: $checkedConvert(
              'paddings',
              (v) => v == null
                  ? const GenerationSettings(generate: false)
                  : GenerationSettings.fromJson(v as Map)),
          radii: $checkedConvert(
              'radii',
              (v) => v == null
                  ? const GenerationSettings(generate: false)
                  : GenerationSettings.fromJson(v as Map)),
        );
        return val;
      },
    );

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
      'packageName': instance.packageName,
      'fileId': instance.fileId,
      'packageDescription': instance.packageDescription,
      'dropUnresolved': instance.dropUnresolved,
      'stylesFromLibrary': instance.stylesFromLibrary,
      'colors': instance.colors.toJson(),
      'typography': instance.typography.toJson(),
      'strings': instance.strings.toJson(),
      'bools': instance.bools.toJson(),
      'numbers': instance.numbers.toJson(),
      'spacers': instance.spacers.toJson(),
      'paddings': instance.paddings.toJson(),
      'radii': instance.radii.toJson(),
    };

GenerationSettings _$GenerationSettingsFromJson(Map json) => $checkedCreate(
      'GenerationSettings',
      json,
      ($checkedConvert) {
        final val = GenerationSettings(
          generate: $checkedConvert('generate', (v) => v as bool? ?? true),
          from: $checkedConvert(
              'from',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as String) ??
                  const <String>[]),
        );
        return val;
      },
    );

Map<String, dynamic> _$GenerationSettingsToJson(GenerationSettings instance) =>
    <String, dynamic>{
      'generate': instance.generate,
      'from': instance.from.toList(),
    };

TypographyGenerationSettings _$TypographyGenerationSettingsFromJson(Map json) =>
    $checkedCreate(
      'TypographyGenerationSettings',
      json,
      ($checkedConvert) {
        final val = TypographyGenerationSettings(
          generate: $checkedConvert('generate', (v) => v as bool? ?? true),
          from: $checkedConvert(
              'from',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as String) ??
                  const <String>[]),
          useGoogleFonts:
              $checkedConvert('useGoogleFonts', (v) => v as bool? ?? true),
        );
        return val;
      },
    );

Map<String, dynamic> _$TypographyGenerationSettingsToJson(
        TypographyGenerationSettings instance) =>
    <String, dynamic>{
      'generate': instance.generate,
      'from': instance.from.toList(),
      'useGoogleFonts': instance.useGoogleFonts,
    };
