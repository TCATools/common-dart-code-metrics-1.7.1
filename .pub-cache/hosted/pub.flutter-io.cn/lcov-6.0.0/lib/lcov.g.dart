// GENERATED CODE - DO NOT MODIFY BY HAND

part of lcov;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$BranchCoverageToJson(BranchCoverage instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e?.toJson())?.toList(),
      'found': instance.found,
      'hit': instance.hit,
    };

Map<String, dynamic> _$BranchDataToJson(BranchData instance) =>
    <String, dynamic>{
      'blockNumber': instance.blockNumber,
      'branchNumber': instance.branchNumber,
      'lineNumber': instance.lineNumber,
      'taken': instance.taken,
    };

Map<String, dynamic> _$FunctionCoverageToJson(FunctionCoverage instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e?.toJson())?.toList(),
      'found': instance.found,
      'hit': instance.hit,
    };

Map<String, dynamic> _$FunctionDataToJson(FunctionData instance) =>
    <String, dynamic>{
      'executionCount': instance.executionCount,
      'functionName': instance.functionName,
      'lineNumber': instance.lineNumber,
    };

Map<String, dynamic> _$LineCoverageToJson(LineCoverage instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e?.toJson())?.toList(),
      'found': instance.found,
      'hit': instance.hit,
    };

Map<String, dynamic> _$LineDataToJson(LineData instance) => <String, dynamic>{
      'checksum': instance.checksum,
      'executionCount': instance.executionCount,
      'lineNumber': instance.lineNumber,
    };

Map<String, dynamic> _$RecordToJson(Record instance) => <String, dynamic>{
      'branches': instance.branches?.toJson(),
      'functions': instance.functions?.toJson(),
      'lines': instance.lines?.toJson(),
      'sourceFile': instance.sourceFile,
    };

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'records': instance.records?.map((e) => e?.toJson())?.toList(),
      'testName': instance.testName,
    };
