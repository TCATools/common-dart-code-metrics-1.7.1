import 'package:lcov/lcov.dart';
import 'package:test/test.dart';

/// Tests the features of the branch coverage.
void main() {
  group('BranchCoverage', () {
    group('.fromJson()', () {
      test('should return an instance with default values for an empty map',
          () {
        final coverage = BranchCoverage.fromJson(<String, dynamic>{});
        expect(coverage.data, allOf(isList, isEmpty));
        expect(coverage.found, 0);
        expect(coverage.hit, 0);
      });

      test('should return an initialized instance for a non-empty map', () {
        final coverage = BranchCoverage.fromJson(<String, dynamic>{
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
        final map = BranchCoverage().toJson();
        expect(map, hasLength(3));
        expect(map['data'], allOf(isList, isEmpty));
        expect(map['found'], 0);
        expect(map['hit'], 0);
      });

      test('should return a non-empty map for an initialized instance', () {
        final map = BranchCoverage(3, 19, [BranchData(0, 0, 0)]).toJson();
        expect(map, hasLength(3));
        expect(map['data'], allOf(isList, hasLength(1)));
        expect(map['data'].first, isMap);
        expect(map['found'], 3);
        expect(map['hit'], 19);
      });
    });

    group('.toString()', () {
      test(r'should return a format like "BRF:<found>\nBRH:<hit>"', () {
        expect(BranchCoverage().toString(), 'BRF:0\nBRH:0');

        final data = BranchData(127, 3, 2);
        expect(
            BranchCoverage(3, 19, [data]).toString(), '$data\nBRF:3\nBRH:19');
      });
    });
  });

  group('BranchData', () {
    group('.fromJson()', () {
      test('should return an instance with default values for an empty map',
          () {
        final data = BranchData.fromJson({});
        expect(data.branchNumber, 0);
        expect(data.blockNumber, 0);
        expect(data.lineNumber, 0);
        expect(data.taken, 0);
      });

      test('should return an initialized instance for a non-empty map', () {
        final data = BranchData.fromJson({
          'blockNumber': 3,
          'branchNumber': 2,
          'lineNumber': 127,
          'taken': 1
        });

        expect(data.branchNumber, 2);
        expect(data.blockNumber, 3);
        expect(data.lineNumber, 127);
        expect(data.taken, 1);
      });
    });

    group('.toJson()', () {
      test(
          'should return a map with default values for a newly created instance',
          () {
        final map = BranchData(0, 0, 0).toJson();
        expect(map, hasLength(4));
        expect(map['blockNumber'], 0);
        expect(map['branchNumber'], 0);
        expect(map['lineNumber'], 0);
        expect(map['taken'], 0);
      });

      test('should return a non-empty map for an initialized instance', () {
        final map = BranchData(127, 3, 2, taken: 1).toJson();
        expect(map, hasLength(4));
        expect(map['blockNumber'], 3);
        expect(map['branchNumber'], 2);
        expect(map['lineNumber'], 127);
        expect(map['taken'], 1);
      });
    });

    group('.toString()', () {
      test(
          'should return a format like "BRDA:<lineNumber>,<blockNumber>,<branchNumber>,<taken>"',
          () {
        expect(BranchData(0, 0, 0).toString(), 'BRDA:0,0,0,-');
        expect(BranchData(127, 3, 2, taken: 1).toString(), 'BRDA:127,3,2,1');
      });
    });
  });
}
