part of "../lcov.dart";

/// Provides the list of tokens supported by the parser.
abstract class Token {
  /// The coverage data of a branch.
  static const branchData = "BRDA";

  /// The number of branches found.
  static const branchesFound = "BRF";

  /// The number of branches hit.
  static const branchesHit = "BRH";

  /// The end of a section.
  static const endOfRecord = "end_of_record";

  /// The coverage data of a function.
  static const functionData = "FNDA";

  /// A function name.
  static const functionName = "FN";

  /// The number of functions found.
  static const functionsFound = "FNF";

  /// The number of functions hit.
  static const functionsHit = "FNH";

  /// The coverage data of a line.
  static const lineData = "DA";

  /// The number of instrumented lines.
  static const linesFound = "LF";

  /// The number of lines with a non-zero execution count.
  static const linesHit = "LH";

  /// The path to a source file.
  static const sourceFile = "SF";

  /// A test name.
  static const testName = "TN";
}
