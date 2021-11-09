part of "../lcov.dart";

/// Provides the coverage data of a source file.
@JsonSerializable(createFactory: false, explicitToJson: true)
class Record {
  /// Creates a new record with the specified source file.
  Record(this.sourceFile, {this.branches, this.functions, this.lines});

  /// The branch coverage.
  BranchCoverage branches;

  /// The function coverage.
  FunctionCoverage functions;

  /// The line coverage.
  LineCoverage lines;

  /// The path to the source file.
  @JsonKey(defaultValue: "")
  String sourceFile;

  /// Converts this object to a [Map] in JSON format.
  Map<String, dynamic> toJson() => _$RecordToJson(this);

  /// Returns a string representation of this object.
  @override
  String toString() {
    final buffer = StringBuffer("${Token.sourceFile}:$sourceFile")..writeln();
    if (functions != null) buffer.writeln(functions);
    if (branches != null) buffer.writeln(branches);
    if (lines != null) buffer.writeln(lines);
    buffer.write(Token.endOfRecord);
    return buffer.toString();
  }
}
