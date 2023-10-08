import 'package:figmage/src/domain/models/variable/variable_value/variable_alias/variable_alias.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'variable_value.freezed.dart';

part 'variable_value.g.dart';

@Freezed(fromJson: true, toJson: true)
class VariableValue with _$VariableValue {
  const factory VariableValue.boolean(bool value) = BooleanValue;

  const factory VariableValue.number(double value) = NumberValue;

  const factory VariableValue.string(String value) = StringValue;

  const factory VariableValue.color(int value) = ColorValue;

  const factory VariableValue.variableAlias(VariableAlias value) =
      VariableAliasValue;
}
