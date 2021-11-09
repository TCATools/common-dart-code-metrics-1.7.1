part of "../lcov.dart";

/// Provides the coverage data of functions.
@JsonSerializable(createFactory: false, explicitToJson: true)
class FunctionCoverage {
  /// Creates a new function coverage.
  FunctionCoverage([this.found = 0, this.hit = 0, Iterable<FunctionData> data])
      : data = data?.toList() ?? <FunctionData>[];

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
            data.map<String>((item) => item.toString(asDefinition: true)), "\n")
        ..writeln()
        ..writeAll(
            data.map<String>((item) => item.toString(asDefinition: false)),
            "\n")
        ..writeln();

    buffer
      ..writeln("${Token.functionsFound}:$found")
      ..write("${Token.functionsHit}:$hit");
    return buffer.toString();
  }
}
