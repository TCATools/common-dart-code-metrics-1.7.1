part of "../lcov.dart";

/// Provides details for function coverage.
@JsonSerializable(createFactory: false)
class FunctionData {
  /// Creates a new function data.
  FunctionData(this.functionName, this.lineNumber, {this.executionCount = 0});

  /// The execution count.
  @JsonKey(defaultValue: 0)
  int executionCount;

  /// The function name.
  @JsonKey(defaultValue: "")
  String functionName;

  /// The line number of the function start.
  @JsonKey(defaultValue: 0)
  int lineNumber;

  /// Converts this object to a [Map] in JSON format.
  Map<String, dynamic> toJson() => _$FunctionDataToJson(this);

  /// Returns a string representation of this object.
  ///
  /// The [asDefinition] parameter indicates whether to return the function definition (i.e. name and line number)
  /// instead of its data (i.e. name and execution count).
  @override
  String toString({bool asDefinition = false}) {
    final token = asDefinition ? Token.functionName : Token.functionData;
    final number = asDefinition ? lineNumber : executionCount;
    return "$token:$number,$functionName";
  }
}
