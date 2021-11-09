import "package:lcov/lcov.dart";
import "package:test/test.dart";

/// Tests the features of the [LineData] class.
void main() => group("LineData", () {
      group(".toJson()", () {
        test(
            "should return a map with default values for a newly created instance",
            () {
          final map = LineData(0).toJson();
          expect(map, hasLength(3));
          expect(map["checksum"], isEmpty);
          expect(map["executionCount"], 0);
          expect(map["lineNumber"], 0);
        });

        test("should return a non-empty map for an initialized instance", () {
          final map = LineData(127,
                  executionCount: 3,
                  checksum: "ed076287532e86365e841e92bfc50d8c")
              .toJson();
          expect(map, hasLength(3));
          expect(map["checksum"], "ed076287532e86365e841e92bfc50d8c");
          expect(map["executionCount"], 3);
          expect(map["lineNumber"], 127);
        });
      });

      group(".toString()", () {
        test(
            "should return a format like 'DA:<lineNumber>,<executionCount>[,<checksum>]'",
            () {
          expect(LineData(0).toString(), "DA:0,0");

          final data = LineData(127,
              executionCount: 3, checksum: "ed076287532e86365e841e92bfc50d8c");
          expect(data.toString(), "DA:127,3,ed076287532e86365e841e92bfc50d8c");
        });
      });
    });
