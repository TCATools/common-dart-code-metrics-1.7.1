import 'package:lcov/lcov.dart';
import 'package:test/test.dart';

/// Tests the features of the line coverage.
void main() {
  group('LineCoverage', () {
    group('.fromJson()', () {
      test('should return an instance with default values for an empty map',
          () {
        final coverage = LineCoverage.fromJson(<String, dynamic>{});
        expect(coverage.data, allOf(isList, isEmpty));
        expect(coverage.found, 0);
        expect(coverage.hit, 0);
      });

      test('should return an initialized instance for a non-empty map', () {
        final coverage = LineCoverage.fromJson(<String, dynamic>{
          'data': [
            {'lineNumber': 127}
          ],
          'found': 3,
          'hit': 19
        });

        expect(coverage.data, hasLength(1));
        expect(coverage.data.first, isNotNull);
        expect(coverage.found, 3);
        expect(coverage.hit, 19);
      });
    });

    group('.toJson()', () {
      test(
          'should return a map with default values for a newly created instance',
          () {
        final map = LineCoverage().toJson();
        expect(map, hasLength(3));
        expect(map['data'], allOf(isList, isEmpty));
        expect(map['found'], 0);
        expect(map['hit'], 0);
      });

      test('should return a non-empty map for an initialized instance', () {
        final map = LineCoverage(3, 19, [LineData(0)]).toJson();
        expect(map, hasLength(3));
        expect(map['data'], allOf(isList, hasLength(1)));
        expect(map['data'].first, isMap);
        expect(map['found'], 3);
        expect(map['hit'], 19);
      });
    });

    group('.toString()', () {
      test(r'should return a format like "LF:<found>\nLH:<hit>"', () {
        expect(LineCoverage().toString(), 'LF:0\nLH:0');

        final data = LineData(127, executionCount: 3);
        expect(LineCoverage(3, 19, [data]).toString(), '$data\nLF:3\nLH:19');
      });
    });
  });

  group('LineData', () {
    group('.fromJson()', () {
      test('should return an instance with default values for an empty map',
          () {
        final data = LineData.fromJson(<String, dynamic>{});
        expect(data.checksum, isEmpty);
        expect(data.executionCount, 0);
        expect(data.lineNumber, 0);
      });

      test('should return an initialized instance for a non-empty map', () {
        final data = LineData.fromJson(<String, dynamic>{
          'checksum': 'ed076287532e86365e841e92bfc50d8c',
          'executionCount': 3,
          'lineNumber': 127
        });

        expect(data.checksum, 'ed076287532e86365e841e92bfc50d8c');
        expect(data.executionCount, 3);
        expect(data.lineNumber, 127);
      });
    });

    group('.toJson()', () {
      test(
          'should return a map with default values for a newly created instance',
          () {
        final map = LineData(0).toJson();
        expect(map, hasLength(3));
        expect(map['checksum'], isEmpty);
        expect(map['executionCount'], 0);
        expect(map['lineNumber'], 0);
      });

      test('should return a non-empty map for an initialized instance', () {
        final map = LineData(127,
                executionCount: 3, checksum: 'ed076287532e86365e841e92bfc50d8c')
            .toJson();
        expect(map, hasLength(3));
        expect(map['checksum'], 'ed076287532e86365e841e92bfc50d8c');
        expect(map['executionCount'], 3);
        expect(map['lineNumber'], 127);
      });
    });

    group('.toString()', () {
      test(
          'should return a format like "DA:<lineNumber>,<executionCount>[,<checksum>]"',
          () {
        expect(LineData(0).toString(), 'DA:0,0');

        final data = LineData(127,
            executionCount: 3, checksum: 'ed076287532e86365e841e92bfc50d8c');
        expect(data.toString(), 'DA:127,3,ed076287532e86365e841e92bfc50d8c');
      });
    });
  });
}
