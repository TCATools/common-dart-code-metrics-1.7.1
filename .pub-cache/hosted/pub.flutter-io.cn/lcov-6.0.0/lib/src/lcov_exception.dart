part of "../lcov.dart";

/// An exception caused by a parsing error.
class LcovException extends FormatException {
  /// Creates a new LCOV exception.
  LcovException(String message, [String source = "", int offset = 0])
      : super(message, source, offset);
}
