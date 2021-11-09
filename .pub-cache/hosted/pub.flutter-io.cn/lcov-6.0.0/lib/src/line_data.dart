part of "../lcov.dart";

/// Provides details for line coverage.
@JsonSerializable(createFactory: false)
class LineData {
  /// Creates a new line data.
  LineData(this.lineNumber, {this.executionCount = 0, this.checksum = ""});

  /// The data checksum.
  @JsonKey(defaultValue: "")
  String checksum;

  /// The execution count.
  @JsonKey(defaultValue: 0)
  int executionCount;

  /// The line number.
  @JsonKey(defaultValue: 0)
  int lineNumber;

  /// Converts this object to a [Map] in JSON format.
  Map<String, dynamic> toJson() => _$LineDataToJson(this);

  /// Returns a string representation of this object.
  @override
  String toString() {
    final value = "${Token.lineData}:$lineNumber,$executionCount";
    return checksum.isEmpty ? value : "$value,$checksum";
  }
}
