part of "../lcov.dart";

/// Provides details for branch coverage.
@JsonSerializable(createFactory: false)
class BranchData {
  /// Creates a new branch data.
  BranchData(this.lineNumber, this.blockNumber, this.branchNumber,
      {this.taken = 0});

  /// The block number.
  @JsonKey(defaultValue: 0)
  int blockNumber;

  /// The branch number.
  @JsonKey(defaultValue: 0)
  int branchNumber;

  /// The line number.
  @JsonKey(defaultValue: 0)
  int lineNumber;

  /// A number indicating how often this branch was taken.
  @JsonKey(defaultValue: 0)
  int taken;

  /// Converts this object to a [Map] in JSON format.
  Map<String, dynamic> toJson() => _$BranchDataToJson(this);

  /// Returns a string representation of this object.
  @override
  String toString() {
    final value = "${Token.branchData}:$lineNumber,$blockNumber,$branchNumber";
    return taken > 0 ? "$value,$taken" : "$value,-";
  }
}
