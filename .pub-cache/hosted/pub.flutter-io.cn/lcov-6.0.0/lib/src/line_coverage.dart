part of "../lcov.dart";

/// Provides the coverage data of lines.
@JsonSerializable(createFactory: false, explicitToJson: true)
class LineCoverage {
  /// Creates a new line coverage.
  LineCoverage([this.found = 0, this.hit = 0, Iterable<LineData> data])
      : data = data?.toList() ?? <LineData>[];

  /// The coverage data.
  @JsonKey(defaultValue: [])
  final List<LineData> data;

  /// The number of instrumented lines.
  @JsonKey(defaultValue: 0)
  int found;

  /// The number of lines with a non-zero execution count.
  @JsonKey(defaultValue: 0)
  int hit;

  /// Converts this object to a [Map] in JSON format.
  Map<String, dynamic> toJson() => _$LineCoverageToJson(this);

  /// Returns a string representation of this object.
  @override
  String toString() {
    final buffer = StringBuffer();
    if (data.isNotEmpty)
      buffer
        ..writeAll(data, "\n")
        ..writeln();
    buffer
      ..writeln("${Token.linesFound}:$found")
      ..write("${Token.linesHit}:$hit");
    return buffer.toString();
  }
}
