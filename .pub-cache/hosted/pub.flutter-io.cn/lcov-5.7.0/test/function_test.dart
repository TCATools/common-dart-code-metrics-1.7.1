import 'package:lcov/lcov.dart';
import 'package:test/test.dart';

/// Tests the features of the function coverage.
void main() {
  group('FunctionCoverage', () {
    group('.fromJson()', () {
      test('should return an instance with default values for an empty map',
          () {
        final coverage = FunctionCoverage.fromJson(<String, dynamic>{});
        expect(coverage.data, allOf(isList, isEmpty));
        expect(coverage.found, 0);
        expect(coverage.hit, 0);
      });

      test('should return an initialized instance for a non-empty map', () {
        final coverage = FunctionCoverage.fromJson(<String, dynamic>{
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
        final map = FunctionCoverage().toJson();
        expect(map, hasLength(3));
        expect(map['data'], allOf(isList, isEmpty));
        expect(map['found'], 0);
        expect(map['hit'], 0);
      });

      test('should return a non-empty map for an initialized instance', () {
        final map = FunctionCoverage(3, 19, [FunctionData('', 0)]).toJson();
        expect(map, hasLength(3));
        expect(map['data'], allOf(isList, hasLength(1)));
        expect(map['data'].first, isMap);
        expect(map['found'], 3);
        expect(map['hit'], 19);
      });
    });

    group('.toString()', () {
      test(r'should return a format like "FNF:<found>\nFNH:<hit>"', () {
        expect(FunctionCoverage().toString(), 'FNF:0\nFNH:0');

        final coverage = FunctionCoverage(
            3, 19, [FunctionData('main', 127, executionCount: 3)]);
        expect(coverage.toString(), 'FN:127,main\nFNDA:3,main\nFNF:3\nFNH:19');
      });
    });
  });

  group('FunctionData', () {
    group('.fromJson()', () {
      test('should return an instance with default values for an empty map',
          () {
        final data = FunctionData.fromJson(<String, dynamic>{});
        expect(data.executionCount, 0);
        expect(data.functionName, isEmpty);
        expect(data.lineNumber, 0);
      });

      test('should return an initialized instance for a non-empty map', () {
        final data = FunctionData.fromJson(<String, dynamic>{
          'executionCount': 3,
          'functionName': 'main',
          'lineNumber': 127
        });

        expect(data.executionCount, 3);
        expect(data.functionName, 'main');
        expect(data.lineNumber, 127);
      });
    });

    group('.toJson()', () {
      test(
          'should return a map with default values for a newly created instance',
          () {
        final map = FunctionData('', 0).toJson();
        expect(map, hasLength(3));
        expect(map['executionCount'], 0);
        expect(map['functionName'], isEmpty);
        expect(map['lineNumber'], 0);
      });

      test('should return a non-empty map for an initialized instance', () {
        final map = FunctionData('main', 127, executionCount: 3).toJson();
        expect(map, hasLength(3));
        expect(map['executionCount'], 3);
        expect(map['functionName'], 'main');
        expect(map['lineNumber'], 127);
      });
    });

    group('.toString()', () {
      test(
          'should return a format like "FN:<lineNumber>,<functionName>" when used as definition',
          () {
        expect(FunctionData('', 0).toString(asDefinition: true), 'FN:0,');
        expect(
            FunctionData('main', 127, executionCount: 3)
                .toString(asDefinition: true),
            'FN:127,main');
      });

      test(
          'should return a format like "FNDA:<executionCount>,<functionName>" when used as data',
          () {
        expect(FunctionData('', 0).toString(asDefinition: false), 'FNDA:0,');
        expect(
            FunctionData('main', 127, executionCount: 3)
                .toString(asDefinition: false),
            'FNDA:3,main');
      });
    });
  });
}
