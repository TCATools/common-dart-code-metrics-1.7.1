// ignore_for_file: avoid_print
import 'dart:io';
import 'package:lcov/lcov.dart';

/// Formats coverage data as LCOV report.
void formatReport() {
  final lineCoverage = LineCoverage(2, 2, [
    LineData(6, executionCount: 2, checksum: 'PF4Rz2r7RTliO9u6bZ7h6g'),
    LineData(7, executionCount: 2, checksum: 'yGMB6FhEEAd8OyASe3Ni1w')
  ]);

  final record = Record('/home/cedx/lcov.dart/fixture.dart')
    ..functions = FunctionCoverage(1, 1)
    ..lines = lineCoverage;

  final report = Report('Example', [record]);
  print(report);
}

/// Parses a LCOV report to coverage data.
Future<void> parseReport() async {
  final coverage = await File('lcov.info').readAsString();

  try {
    final report = Report.fromCoverage(coverage);
    print('The coverage report contains ${report.records.length} records:');
    print(report.toJson());
  }

  on LcovException catch (err) {
    print('An error occurred: ${err.message}');
  }
}
