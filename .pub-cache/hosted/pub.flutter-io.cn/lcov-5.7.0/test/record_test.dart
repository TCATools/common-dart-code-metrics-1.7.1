import 'package:lcov/lcov.dart';
import 'package:test/test.dart';

/// Tests the features of the [Record] class.
void main() => group('Record', () {
      group('.fromJson()', () {
        test('should return an instance with default values for an empty map',
            () {
          final record = Record.fromJson(<String, dynamic>{});
          expect(record.branches, isNull);
          expect(record.functions, isNull);
          expect(record.lines, isNull);
          expect(record.sourceFile, isEmpty);
        });

        test('should return an initialized instance for a non-empty map', () {
          final record = Record.fromJson(<String, dynamic>{
            'branches': <String, dynamic>{},
            'functions': <String, dynamic>{},
            'lines': <String, dynamic>{},
            'sourceFile': '/home/cedx/lcov.dart'
          });

          expect(record.branches, isNotNull);
          expect(record.functions, isNotNull);
          expect(record.lines, isNotNull);
          expect(record.sourceFile, '/home/cedx/lcov.dart');
        });
      });

      group('.toJson()', () {
        test(
            'should return a map with default values for a newly created instance',
            () {
          final map = Record('').toJson();
          expect(map, hasLength(4));
          expect(map['branches'], isNull);
          expect(map['functions'], isNull);
          expect(map['lines'], isNull);
          expect(map['sourceFile'], isEmpty);
        });

        test('should return a non-empty map for an initialized instance', () {
          final map = (Record('/home/cedx/lcov.dart')
                ..branches = BranchCoverage()
                ..functions = FunctionCoverage()
                ..lines = LineCoverage())
              .toJson();

          expect(map, hasLength(4));
          expect(map['branches'], isMap);
          expect(map['functions'], isMap);
          expect(map['lines'], isMap);
          expect(map['sourceFile'], '/home/cedx/lcov.dart');
        });
      });

      group('.toString()', () {
        test(r'should return a format like "SF:<sourceFile>\nend_of_record"',
            () {
          expect(Record('').toString(), 'SF:\nend_of_record');

          final record = Record('/home/cedx/lcov.dart')
            ..branches = BranchCoverage()
            ..functions = FunctionCoverage()
            ..lines = LineCoverage();

          expect(record.toString(),
              'SF:/home/cedx/lcov.dart\n${record.functions}\n${record.branches}\n${record.lines}\nend_of_record');
        });
      });
    });
