import "package:lcov/lcov.dart";
import "package:test/test.dart";

/// Tests the features of the [BranchData] class.
void main() => group("BranchData", () {
      group(".toJson()", () {
        test(
            "should return a map with default values for a newly created instance",
            () {
          final map = BranchData(0, 0, 0).toJson();
          expect(map, hasLength(4));
          expect(map["blockNumber"], 0);
          expect(map["branchNumber"], 0);
          expect(map["lineNumber"], 0);
          expect(map["taken"], 0);
        });

        test("should return a non-empty map for an initialized instance", () {
          final map = BranchData(127, 3, 2, taken: 1).toJson();
          expect(map, hasLength(4));
          expect(map["blockNumber"], 3);
          expect(map["branchNumber"], 2);
          expect(map["lineNumber"], 127);
          expect(map["taken"], 1);
        });
      });

      group(".toString()", () {
        test(
            "should return a format like 'BRDA:<lineNumber>,<blockNumber>,<branchNumber>,<taken>'",
            () {
          expect(BranchData(0, 0, 0).toString(), "BRDA:0,0,0,-");
          expect(BranchData(127, 3, 2, taken: 1).toString(), "BRDA:127,3,2,1");
        });
      });
    });
