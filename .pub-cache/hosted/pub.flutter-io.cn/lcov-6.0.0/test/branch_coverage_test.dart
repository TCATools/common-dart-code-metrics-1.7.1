import "package:lcov/lcov.dart";
import "package:test/test.dart";

/// Tests the features of the [BranchCoverage] class.
void main() => group("BranchCoverage", () {
      group(".toJson()", () {
        test(
            "should return a map with default values for a newly created instance",
            () {
          final map = BranchCoverage().toJson();
          expect(map, hasLength(3));
          expect(map["data"], allOf(isList, isEmpty));
          expect(map["found"], 0);
          expect(map["hit"], 0);
        });

        test("should return a non-empty map for an initialized instance", () {
          final map = BranchCoverage(3, 19, [BranchData(0, 0, 0)]).toJson();
          expect(map, hasLength(3));
          expect(map["data"], allOf(isList, hasLength(1)));
          expect(map["data"].first, isMap);
          expect(map["found"], 3);
          expect(map["hit"], 19);
        });
      });

      group(".toString()", () {
        test(r"should return a format like 'BRF:<found>\nBRH:<hit>'", () {
          expect(BranchCoverage().toString(), "BRF:0\nBRH:0");

          final data = BranchData(127, 3, 2);
          expect(
              BranchCoverage(3, 19, [data]).toString(), "$data\nBRF:3\nBRH:19");
        });
      });
    });
