part of '../lcov.dart';

/// Provides the coverage data of lines.
@JsonSerializable(explicitToJson: true)
class LineCoverage {
  /// Creates a new line coverage.
  LineCoverage([this.found = 0, this.hit = 0, Iterable<LineData> data])
      : assert(found >= 0),
        assert(hit >= 0),
        data = data?.toList() ?? <LineData>[];

  /// Creates a new line coverage from the specified [map] in JSON format.
  factory LineCoverage.fromJson(Map<String, dynamic> map) =>
      _$LineCoverageFromJson(map);

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
        ..writeAll(data, '\n')
        ..writeln();
    buffer
      ..writeln('${Token.linesFound}:$found')
      ..write('${Token.linesHit}:$hit');

    return buffer.toString();
  }
}

/// Provides details for line coverage.
@JsonSerializable()
class LineData {
  /// Creates a new line data.
  LineData(this.lineNumber, {this.executionCount = 0, this.checksum = ''})
      : assert(lineNumber >= 0),
        assert(executionCount >= 0);

  /// Creates a new line data from the specified [map] in JSON format.
  factory LineData.fromJson(Map<String, dynamic> map) =>
      _$LineDataFromJson(map);

  /// The data checksum.
  @JsonKey(defaultValue: '')
  final String checksum;

  /// The execution count.
  @JsonKey(defaultValue: 0)
  int executionCount;

  /// The line number.
  @JsonKey(defaultValue: 0)
  final int lineNumber;

  /// Converts this object to a [Map] in JSON format.
  Map<String, dynamic> toJson() => _$LineDataToJson(this);

  /// Returns a string representation of this object.
  @override
  String toString() {
    final value = '${Token.lineData}:$lineNumber,$executionCount';
    return checksum.isEmpty ? value : '$value,$checksum';
  }
}
