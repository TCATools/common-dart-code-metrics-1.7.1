part of '../lcov.dart';

/// Provides the coverage data of functions.
@JsonSerializable(explicitToJson: true)
class FunctionCoverage {
  /// Creates a new function coverage.
  FunctionCoverage([this.found = 0, this.hit = 0, Iterable<FunctionData> data])
      : assert(found >= 0),
        assert(hit >= 0),
        data = data?.toList() ?? <FunctionData>[];

  /// Creates a new function coverage from the specified [map] in JSON format.
  factory FunctionCoverage.fromJson(Map<String, dynamic> map) =>
      _$FunctionCoverageFromJson(map);

  /// The coverage data.
  @JsonKey(defaultValue: [])
  final List<FunctionData> data;

  /// The number of functions found.
  @JsonKey(defaultValue: 0)
  int found;

  /// The number of functions hit.
  @JsonKey(defaultValue: 0)
  int hit;

  /// Converts this object to a [Map] in JSON format.
  Map<String, dynamic> toJson() => _$FunctionCoverageToJson(this);

  /// Returns a string representation of this object.
  @override
  String toString() {
    final buffer = StringBuffer();
    if (data.isNotEmpty)
      buffer
        ..writeAll(
            data.map<String>((item) => item.toString(asDefinition: true)), '\n')
        ..writeln()
        ..writeAll(
            data.map<String>((item) => item.toString(asDefinition: false)),
            '\n')
        ..writeln();

    buffer
      ..writeln('${Token.functionsFound}:$found')
      ..write('${Token.functionsHit}:$hit');
    return buffer.toString();
  }
}

/// Provides details for function coverage.
@JsonSerializable()
class FunctionData {
  /// Creates a new function data.
  FunctionData(this.functionName, this.lineNumber, {this.executionCount = 0})
      : assert(lineNumber >= 0),
        assert(executionCount >= 0);

  /// Creates a new function data from the specified [map] in JSON format.
  factory FunctionData.fromJson(Map<String, dynamic> map) =>
      _$FunctionDataFromJson(map);

  /// The execution count.
  @JsonKey(defaultValue: 0)
  int executionCount;

  /// The function name.
  @JsonKey(defaultValue: '')
  final String functionName;

  /// The line number of the function start.
  @JsonKey(defaultValue: 0)
  final int lineNumber;

  /// Converts this object to a [Map] in JSON format.
  Map<String, dynamic> toJson() => _$FunctionDataToJson(this);

  /// Returns a string representation of this object.
  ///
  /// The [asDefinition] parameter indicates whether to return the function definition (e.g. name and line number)
  /// instead of its data (e.g. name and execution count).
  @override
  String toString({bool asDefinition = false}) {
    final token = asDefinition ? Token.functionName : Token.functionData;
    final number = asDefinition ? lineNumber : executionCount;
    return '$token:$number,$functionName';
  }
}
