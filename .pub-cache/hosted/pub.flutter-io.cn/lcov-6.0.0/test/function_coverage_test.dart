import "package:lcov/lcov.dart";
import "package:test/test.dart";

/// Tests the features of the [FunctionCoverage] class.
void main() => group("FunctionCoverage", () {
      group(".toJson()", () {
        test(
            "should return a map with default values for a newly created instance",
            () {
          final map = FunctionCoverage().toJson();
          expect(map, hasLength(3));
          expect(map["data"], allOf(isList, isEmpty));
          expect(map["found"], 0);
          expect(map["hit"], 0);
        });

        test("should return a non-empty map for an initialized instance", () {
          final map = FunctionCoverage(3, 19, [FunctionData("", 0)]).toJson();
          expect(map, hasLength(3));
          expect(map["data"], allOf(isList, hasLength(1)));
          expect(map["data"].first, isMap);
          expect(map["found"], 3);
          expect(map["hit"], 19);
        });
      });

      group(".toString()", () {
        test(r"should return a format like 'FNF:<found>\nFNH:<hit>'", () {
          expect(FunctionCoverage().toString(), "FNF:0\nFNH:0");

          final coverage = FunctionCoverage(
              3, 19, [FunctionData("main", 127, executionCount: 3)]);
          expect(
              coverage.toString(), "FN:127,main\nFNDA:3,main\nFNF:3\nFNH:19");
        });
      });
    });
