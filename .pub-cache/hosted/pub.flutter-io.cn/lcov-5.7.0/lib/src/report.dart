part of '../lcov.dart';
// ignore_for_file: invariant_booleans

/// An exception caused by a parsing error.
class LcovException extends FormatException {
  /// Creates a new LCOV exception.
  LcovException(String message, [String source = '', int offset = 0])
      : assert(offset >= 0),
        super(message, source, offset);
}

/// Represents a trace file, that is a coverage report.
@JsonSerializable(explicitToJson: true)
class Report {
  /// Creates a new report.
  Report([this.testName = '', Iterable<Record> records])
      : records = records?.toList() ?? <Record>[];

  /// Parses the specified [coverage] data in [LCOV](http://ltp.sourceforge.net/coverage/lcov.php) format.
  /// Throws a [LcovException] if a parsing error occurred.
  Report.fromCoverage(String coverage)
      : records = <Record>[],
        testName = '' {
    try {
      Record record;
      for (var line in coverage.split(RegExp(r'\r?\n'))) {
        line = line.trim();
        if (line.isEmpty) continue;

        final parts = line.split(':');
        if (parts.length < 2 && parts.first != Token.endOfRecord)
          throw Exception('Invalid token format');

        final data = parts.skip(1).join(':').split(',');
        switch (parts.first) {
          case Token.testName:
            testName = data.first;
            break;

          case Token.sourceFile:
            record = Record(data.first)
              ..branches = BranchCoverage()
              ..functions = FunctionCoverage()
              ..lines = LineCoverage();
            break;

          case Token.functionName:
            if (data.length < 2) throw Exception('Invalid function name');
            record.functions.data
                .add(FunctionData(data[1], int.parse(data.first, radix: 10)));
            break;

          case Token.functionData:
            if (data.length < 2) throw Exception('Invalid function data');
            record.functions.data
                .firstWhere((item) => item.functionName == data[1])
                .executionCount = int.parse(data.first, radix: 10);
            break;

          case Token.functionsFound:
            record.functions.found = int.parse(data.first, radix: 10);
            break;

          case Token.functionsHit:
            record.functions.hit = int.parse(data.first, radix: 10);
            break;

          case Token.branchData:
            if (data.length < 4) throw Exception('Invalid branch data');
            record.branches.data.add(BranchData(int.parse(data[0], radix: 10),
                int.parse(data[1], radix: 10), int.parse(data[2], radix: 10),
                taken: data[3] == '-' ? 0 : int.parse(data[3], radix: 10)));
            break;

          case Token.branchesFound:
            record.branches.found = int.parse(data.first, radix: 10);
            break;

          case Token.branchesHit:
            record.branches.hit = int.parse(data.first, radix: 10);
            break;

          case Token.lineData:
            if (data.length < 2) throw Exception('Invalid line data');
            record.lines.data.add(LineData(int.parse(data[0], radix: 10),
                executionCount: int.parse(data[1], radix: 10),
                checksum: data.length >= 3 ? data[2] : ''));
            break;

          case Token.linesFound:
            record.lines.found = int.parse(data.first, radix: 10);
            break;

          case Token.linesHit:
            record.lines.hit = int.parse(data.first, radix: 10);
            break;

          case Token.endOfRecord:
            records.add(record);
            break;
        }
      }
    } on Exception {
      throw LcovException(
          'The coverage data has an invalid LCOV format', coverage);
    }

    if (records.isEmpty)
      throw LcovException('The coverage data is empty', coverage);
  }

  /// Creates a new report from the specified [map] in JSON format.
  factory Report.fromJson(Map<String, dynamic> map) => _$ReportFromJson(map);

  /// The record list.
  @JsonKey(defaultValue: [])
  final List<Record> records;

  /// The test name.
  @JsonKey(defaultValue: '')
  String testName;

  /// Converts this object to a [Map] in JSON format.
  Map<String, dynamic> toJson() => _$ReportToJson(this);

  /// Returns a string representation of this object.
  @override
  String toString() {
    final buffer = StringBuffer();
    if (testName.isNotEmpty) {
      buffer.write('${Token.testName}:$testName');
      if (records.isNotEmpty) buffer.writeln();
    }

    buffer.writeAll(records, '\n');
    return buffer.toString();
  }
}
