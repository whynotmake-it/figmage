import 'package:figma/figma.dart';
import 'package:figmage/src/domain/models/variable/alias_or/alias_or.dart';
import 'package:figmage/src/domain/models/variable/variable.dart';
import 'package:figmage/src/domain/models/variable/variable_type.dart';
import 'package:figmage/src/domain/repositories/variables_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// Visible for testing
@visibleForTesting
typedef VariablesData = ({
  Map<String, Variable<dynamic>> variables,
  Map<String, LocalVariableCollection> variableCollections
});

/// The implementation of [VariablesRepository] for Figma.
class FigmaVariablesRepository implements VariablesRepository {
  @override
  Future<List<Variable<dynamic>>> getVariables({
    required String fileId,
    required String token,
  }) async {
    return fromDtoToModel(
      await _getLocaleVariables(fileId: fileId, token: token),
    );
  }

  Future<LocalVariablesResponse> _getLocaleVariables({
    required String fileId,
    required String token,
  }) async {
    final client = FigmaClient(token);
    try {
      // ignore: unnecessary_await_in_return
      return await client.getLocalVariables(fileId);
    } on FigmaException catch (e) {
      if (e.code == 403) {
        throw const UnauthorizedVariablesException();
      } else {
        throw UnknownVariablesException(e.message ?? e.toString());
      }
    } catch (e) {
      throw UnknownVariablesException(e.toString());
    }
  }

  /// Converts a list of DTO variables into model variables.
  ///
  /// Given a [LocalVariablesResponse], this method processes the variables
  /// within it, maps them to model variables, and returns a list of variables.
  @visibleForTesting
  List<Variable<dynamic>> fromDtoToModel(
    LocalVariablesResponse variablesResponse,
  ) {
    final variableCollections = variablesResponse.meta.variableCollections;
    final dtoVariables = variablesResponse.meta.variables;

    final variables = dtoVariables.values.map((dtoVariable) {
      final variableCollection =
          variableCollections[dtoVariable.variableCollectionId];
      assert(variableCollection != null, 'VariableCollection can not be null');
      final modeNamesById = {
        for (final item in variableCollection!.modes) item.modeId: item.name,
      };
      final collectionName = variableCollection.name;

      final resolvedType =
          VariableTypeX.fromResolvedDataType(dtoVariable.resolvedType);
      
      final codeSyntax = <String, String>{
        if (dtoVariable.codeSyntax.web != null)
          'WEB': dtoVariable.codeSyntax.web!,
        if (dtoVariable.codeSyntax.android != null)
          'ANDROID': dtoVariable.codeSyntax.android!,
        if (dtoVariable.codeSyntax.iOs != null)
          'iOS': dtoVariable.codeSyntax.iOs!,
      };

      final scopes = dtoVariable.scopes.map(_variableScopeToString).toList();

      return switch (resolvedType) {
        VariableType.string => StringVariable(
            id: dtoVariable.id,
            name: dtoVariable.name,
            remote: dtoVariable.remote,
            key: dtoVariable.key,
            variableCollectionId: dtoVariable.variableCollectionId,
            variableCollectionName: collectionName,
            resolvedType: resolvedType,
            description: dtoVariable.description,
            hiddenFromPublishing: dtoVariable.hiddenFromPublishing,
            scopes: scopes,
            codeSyntax: codeSyntax,
            deletedButReferenced: dtoVariable.deletedButReferenced,
            valuesByModeId: dtoVariable.valuesByMode.map(
              (key, value) => MapEntry(
                key,
                _resolveAlias(value: value, dtoVariables: dtoVariables),
              ),
            ),
            collectionModeNamesById: modeNamesById,
          ),
        VariableType.boolean => BoolVariable(
            id: dtoVariable.id,
            name: dtoVariable.name,
            remote: dtoVariable.remote,
            key: dtoVariable.key,
            variableCollectionId: dtoVariable.variableCollectionId,
            variableCollectionName: collectionName,
            resolvedType: resolvedType,
            description: dtoVariable.description,
            hiddenFromPublishing: dtoVariable.hiddenFromPublishing,
            scopes: scopes,
            codeSyntax: codeSyntax,
            deletedButReferenced: dtoVariable.deletedButReferenced,
            valuesByModeId: dtoVariable.valuesByMode.map(
              (key, value) => MapEntry(
                key,
                _resolveAlias(value: value, dtoVariables: dtoVariables),
              ),
            ),
            collectionModeNamesById: modeNamesById,
          ),
        VariableType.color => ColorVariable(
            id: dtoVariable.id,
            name: dtoVariable.name,
            remote: dtoVariable.remote,
            key: dtoVariable.key,
            variableCollectionId: dtoVariable.variableCollectionId,
            variableCollectionName: collectionName,
            resolvedType: resolvedType,
            description: dtoVariable.description,
            hiddenFromPublishing: dtoVariable.hiddenFromPublishing,
            scopes: scopes,
            codeSyntax: codeSyntax,
            deletedButReferenced: dtoVariable.deletedButReferenced,
            valuesByModeId: dtoVariable.valuesByMode.map(
              (key, value) => MapEntry(
                key,
                _resolveAlias(value: value, dtoVariables: dtoVariables),
              ),
            ),
            collectionModeNamesById: modeNamesById,
          ),
        VariableType.float => FloatVariable(
            id: dtoVariable.id,
            name: dtoVariable.name,
            remote: dtoVariable.remote,
            key: dtoVariable.key,
            variableCollectionId: dtoVariable.variableCollectionId,
            variableCollectionName: collectionName,
            resolvedType: resolvedType,
            description: dtoVariable.description,
            hiddenFromPublishing: dtoVariable.hiddenFromPublishing,
            scopes: scopes,
            codeSyntax: codeSyntax,
            deletedButReferenced: dtoVariable.deletedButReferenced,
            valuesByModeId: dtoVariable.valuesByMode.map(
              (key, value) => MapEntry(
                key,
                _resolveAlias(value: value, dtoVariables: dtoVariables),
              ),
            ),
            collectionModeNamesById: modeNamesById,
          ),
      };
    });
    return variables.cast<Variable<dynamic>>().toList();
  }

  /// A helper function for resolving alias values within Figma variables.
  ///
  /// Parameters:
  /// - `value`: The variable mode value data to resolve.
  /// - `dtoVariables`: A map of variable data for resolving aliases.
  ///
  /// Returns an [AliasOr] object containing the resolved value.
  AliasOr<T> _resolveAlias<T>({
    required VariableValue value,
    required Map<String, LocalVariable> dtoVariables,
  }) {
    if (value case final VariableAlias aliasDto) {
      if (dtoVariables.containsKey(aliasDto.id) == false) {
        return AliasUnresolved(id: aliasDto.id);
      }
    }
    return switch (value) {
      VariableAlias() => Alias(
          id: value.id,
          aliasOrValue: _resolveAlias(
            value: dtoVariables[value.id]!.valuesByMode.values.first,
            dtoVariables: dtoVariables,
          ),
        ),
      bool() => AliasData(data: value as T),
      num() => AliasData(data: _convertNumeric<T>(value)),
      String() => AliasData(data: value as T),
      Rgba() => AliasData(data: _rgbaToInt(value) as T),
      _ => throw UnimplementedError(
          'Unsupported value type: ${value.runtimeType}',
        ),
    };
  }

  T _convertNumeric<T>(num value) {
    if (T == double) {
      return value.toDouble() as T;
    } else if (T == int) {
      return value.toInt() as T;
    } else {
      return value as T;
    }
  }

  String _variableScopeToString(VariableScope scope) {
    return switch (scope) {
      VariableScope.allScopes => 'ALL_SCOPES',
      VariableScope.textContent => 'TEXT_CONTENT',
      VariableScope.cornerRadius => 'CORNER_RADIUS',
      VariableScope.widthHeight => 'WIDTH_HEIGHT',
      VariableScope.gap => 'GAP',
      VariableScope.allFills => 'ALL_FILLS',
      VariableScope.frameFill => 'FRAME_FILL',
      VariableScope.shapeFill => 'SHAPE_FILL',
      VariableScope.textFill => 'TEXT_FILL',
      VariableScope.strokeColor => 'STROKE_COLOR',
      VariableScope.strokeFloat => 'STROKE_FLOAT',
      VariableScope.effectFloat => 'EFFECT_FLOAT',
      VariableScope.effectColor => 'EFFECT_COLOR',
      VariableScope.opacity => 'OPACITY',
      VariableScope.fontFamily => 'FONT_FAMILY',
      VariableScope.fontStyle => 'FONT_STYLE',
      VariableScope.fontWeight => 'FONT_WEIGHT',
      VariableScope.fontSize => 'FONT_SIZE',
      VariableScope.lineHeight => 'LINE_HEIGHT',
      VariableScope.letterSpacing => 'LETTER_SPACING',
      VariableScope.paragraphSpacing => 'PARAGRAPH_SPACING',
      VariableScope.paragraphIndent => 'PARAGRAPH_INDENT',
      VariableScope.fontVariations => 'FONT_VARIATIONS',
    };
  }

  int _rgbaToInt(Rgba rgba) {
    final r = (rgba.r * 255).round();
    final g = (rgba.g * 255).round();
    final b = (rgba.b * 255).round();
    final a = (rgba.a * 255).round();
    return (a << 24) | (r << 16) | (g << 8) | b;
  }
}
