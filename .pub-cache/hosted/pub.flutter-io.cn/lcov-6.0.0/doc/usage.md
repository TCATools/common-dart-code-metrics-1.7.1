---
path: src/branch/master
source: lib/src/report.dart
---

# Usage
**LCOV Reports for Dart** provides a set of classes representing a [LCOV](http://ltp.sourceforge.net/coverage/lcov.php) coverage report and its data.
The `Report` class, the main one, provides the parsing and formatting features.

## Parse coverage data from a LCOV file
The `Report.fromCoverage()` factory parses a [LCOV](http://ltp.sourceforge.net/coverage/lcov.php) coverage report provided as string, and creates a `Report` instance giving detailed information about this coverage report:

``` dart
import "dart:convert";
import "dart:io";
import "package:lcov/lcov.dart";

Future<void> main() async {
	try {
		final coverage = await File("/path/to/lcov.info").readAsString();
		final report = Report.fromCoverage(coverage);

		final count = report.records.length;
		print("The coverage report contains $count records:");
		print(const JsonEncoder.withIndent("\t").convert(report));
	}

	on LcovException catch (e) {
		print("An error occurred: ${e.message}");
	}
}
```

!!! info
	A `LcovException` is thrown if any error occurred while parsing the coverage report.

Converting the `Report` instance to [JSON](https://www.json.org) format will return a map like this:

``` json
{
	"testName": "Example",
	"records": [
		{
			"sourceFile": "/home/cedx/lcov.dart/fixture.dart",
			"branches": {
				"found": 0,
				"hit": 0,
				"data": []
			},
			"functions": {
				"found": 1,
				"hit": 1,
				"data": [
					{"functionName": "main", "lineNumber": 4, "executionCount": 2}
				]
			},
			"lines": {
				"found": 2,
				"hit": 2,
				"data": [
					{"lineNumber": 6, "executionCount": 2, "checksum": "PF4Rz2r7RTliO9u6bZ7h6g"},
					{"lineNumber": 9, "executionCount": 2, "checksum": "y7GE3Y4FyXCeXcrtqgSVzw"}
				]
			}
		}
	]
}
```
!!! tip
	See the [API reference](https://api.belin.io/lcov.dart) of this library for more information on the `Report` class.

## Format coverage data to the LCOV format
Each provided class has a dedicated `toString()` instance method returning the corresponding data formatted as [LCOV](http://ltp.sourceforge.net/coverage/lcov.php) string.
All you have to do is to create the adequate structure using these different classes, and to export the final result:

``` dart
import "package:lcov/lcov.dart";

void main() {
	final lineCoverage = LineCoverage(2, 2, [
		LineData(6, executionCount: 2, checksum: "PF4Rz2r7RTliO9u6bZ7h6g"),
		LineData(7, executionCount: 2, checksum: "yGMB6FhEEAd8OyASe3Ni1w")
	]);

	final record = Record("/home/cedx/lcov.dart/fixture.dart")
		..functions = FunctionCoverage(1, 1)
		..lines = lineCoverage;

	final report = Report("Example", [record]);
	print(report);
}
```

The `Report.toString()` method will return a [LCOV](http://ltp.sourceforge.net/coverage/lcov.php) report formatted like this:

```
TN:Example
SF:/home/cedx/lcov.dart/fixture.dart
FNF:1
FNH:1
DA:6,2,PF4Rz2r7RTliO9u6bZ7h6g
DA:7,2,yGMB6FhEEAd8OyASe3Ni1w
LF:2
LH:2
end_of_record
```

!!! tip
	See the [API reference](https://api.belin.io/lcov.dart) of this library for detailed information on the available classes.
