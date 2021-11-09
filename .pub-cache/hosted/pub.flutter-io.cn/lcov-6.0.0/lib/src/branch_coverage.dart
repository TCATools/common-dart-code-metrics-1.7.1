part of "../lcov.dart";

/// Provides the coverage data of branches.
@JsonSerializable(createFactory: false, explicitToJson: true)
class BranchCoverage {
  /// Creates a new branch coverage.
  BranchCoverage([this.found = 0, this.hit = 0, Iterable<BranchData> data])
      : data = data?.toList() ?? <BranchData>[];

  /// The coverage data.
  @JsonKey(defaultValue: [])
  final List<BranchData> data;

  /// The number of branches found.
  @JsonKey(defaultValue: 0)
  int found;

  /// The number of branches hit.
  @JsonKey(defaultValue: 0)
  int hit;

  /// Converts this object to a [Map] in JSON format.
  Map<String, dynamic> toJson() => _$BranchCoverageToJson(this);

  /// Returns a string representation of this object.
  @override
  String toString() {
    final buffer = StringBuffer();
    if (data.isNotEmpty)
      buffer
        ..writeAll(data, "\n")
        ..writeln();
    buffer
      ..writeln("${Token.branchesFound}:$found")
      ..write("${Token.branchesHit}:$hit");
    return buffer.toString();
  }
}
