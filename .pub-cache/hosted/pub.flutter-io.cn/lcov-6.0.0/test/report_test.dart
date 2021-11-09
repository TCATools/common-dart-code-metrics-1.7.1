import "dart:io";
import "package:lcov/lcov.dart";
import "package:test/test.dart";

/// Tests the features of the [Report] class.
void main() => group("Report", () {
      group(".fromCoverage()", () {
        final report = Report.fromCoverage(
            File("test/fixtures/lcov.info").readAsStringSync());

        test("should have a test name", () {
          expect(report.testName, "Example");
        });

        test("should contain three records", () {
          expect(report.records, hasLength(3));
          expect(report.records.first, isNotNull);
          expect(report.records[0].sourceFile,
              "/home/cedx/lcov.dart/fixture.dart");
          expect(
              report.records[1].sourceFile, "/home/cedx/lcov.dart/func1.dart");
          expect(
              report.records[2].sourceFile, "/home/cedx/lcov.dart/func2.dart");
        });

        test("should have detailed branch coverage", () {
          final branches = report.records[1].branches;
          expect(branches.found, 4);
          expect(branches.hit, 4);

          expect(branches.data, hasLength(4));
          expect(branches.data.first, isNotNull);
          expect(branches.data.first.lineNumber, 8);
        });

        test("should have detailed function coverage", () {
          final functions = report.records[1].functions;
          expect(functions.found, 1);
          expect(functions.hit, 1);

          expect(functions.data, hasLength(1));
          expect(functions.data.first, isNotNull);
          expect(functions.data.first.functionName, "func1");
        });

        test("should have detailed line coverage", () {
          final lines = report.records[1].lines;
          expect(lines.found, 9);
          expect(lines.hit, 9);

          expect(lines.data, hasLength(9));
          expect(lines.data.first, isNotNull);
          expect(lines.data.first.checksum, "5kX7OTfHFcjnS98fjeVqNA");
        });

        test("should throw an error if the input is invalid", () {
          expect(() => Report.fromCoverage("ZZ"),
              throwsA(const TypeMatcher<LcovException>()));
        });

        test("should throw an error if the report is empty", () {
          expect(() => Report.fromCoverage("TN:Example"),
              throwsA(const TypeMatcher<LcovException>()));
        });
      });

      group(".toJson()", () {
        test(
            "should return a map with default values for a newly created instance",
            () {
          final map = Report().toJson();
          expect(map, hasLength(2));
          expect(map["records"], allOf(isList, isEmpty));
          expect(map["testName"], isEmpty);
        });

        test("should return a non-empty map for an initialized instance", () {
          final map = Report("LcovTest", [Record("")]).toJson();
          expect(map, hasLength(2));
          expect(map["records"], allOf(isList, hasLength(1)));
          expect(map["records"].first, isMap);
          expect(map["testName"], "LcovTest");
        });
      });

      group(".toString()", () {
        test("should return a format like 'TN:<testName>'", () {
          expect(Report().toString(), isEmpty);

          final record = Record("");
          expect(
              Report("LcovTest", [record]).toString(), "TN:LcovTest\n$record");
        });
      });
    });
