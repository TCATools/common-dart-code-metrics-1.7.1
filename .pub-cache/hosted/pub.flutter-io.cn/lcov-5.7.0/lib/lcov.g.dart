// GENERATED CODE - DO NOT MODIFY BY HAND

part of lcov;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchCoverage _$BranchCoverageFromJson(Map<String, dynamic> json) {
  return BranchCoverage(
    json['found'] as int ?? 0,
    json['hit'] as int ?? 0,
    (json['data'] as List)?.map((e) => e == null
            ? null
            : BranchData.fromJson(e as Map<String, dynamic>)) ??
        [],
  );
}

Map<String, dynamic> _$BranchCoverageToJson(BranchCoverage instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e?.toJson())?.toList(),
      'found': instance.found,
      'hit': instance.hit,
    };

BranchData _$BranchDataFromJson(Map<String, dynamic> json) {
  return BranchData(
    json['lineNumber'] as int ?? 0,
    json['blockNumber'] as int ?? 0,
    json['branchNumber'] as int ?? 0,
    taken: json['taken'] as int ?? 0,
  );
}

Map<String, dynamic> _$BranchDataToJson(BranchData instance) =>
    <String, dynamic>{
      'blockNumber': instance.blockNumber,
      'branchNumber': instance.branchNumber,
      'lineNumber': instance.lineNumber,
      'taken': instance.taken,
    };

FunctionCoverage _$FunctionCoverageFromJson(Map<String, dynamic> json) {
  return FunctionCoverage(
    json['found'] as int ?? 0,
    json['hit'] as int ?? 0,
    (json['data'] as List)?.map((e) => e == null
            ? null
            : FunctionData.fromJson(e as Map<String, dynamic>)) ??
        [],
  );
}

Map<String, dynamic> _$FunctionCoverageToJson(FunctionCoverage instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e?.toJson())?.toList(),
      'found': instance.found,
      'hit': instance.hit,
    };

FunctionData _$FunctionDataFromJson(Map<String, dynamic> json) {
  return FunctionData(
    json['functionName'] as String ?? '',
    json['lineNumber'] as int ?? 0,
    executionCount: json['executionCount'] as int ?? 0,
  );
}

Map<String, dynamic> _$FunctionDataToJson(FunctionData instance) =>
    <String, dynamic>{
      'executionCount': instance.executionCount,
      'functionName': instance.functionName,
      'lineNumber': instance.lineNumber,
    };

LineCoverage _$LineCoverageFromJson(Map<String, dynamic> json) {
  return LineCoverage(
    json['found'] as int ?? 0,
    json['hit'] as int ?? 0,
    (json['data'] as List)?.map((e) =>
            e == null ? null : LineData.fromJson(e as Map<String, dynamic>)) ??
        [],
  );
}

Map<String, dynamic> _$LineCoverageToJson(LineCoverage instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e?.toJson())?.toList(),
      'found': instance.found,
      'hit': instance.hit,
    };

LineData _$LineDataFromJson(Map<String, dynamic> json) {
  return LineData(
    json['lineNumber'] as int ?? 0,
    executionCount: json['executionCount'] as int ?? 0,
    checksum: json['checksum'] as String ?? '',
  );
}

Map<String, dynamic> _$LineDataToJson(LineData instance) => <String, dynamic>{
      'checksum': instance.checksum,
      'executionCount': instance.executionCount,
      'lineNumber': instance.lineNumber,
    };

Record _$RecordFromJson(Map<String, dynamic> json) {
  return Record(
    json['sourceFile'] as String ?? '',
    branches: json['branches'] == null
        ? null
        : BranchCoverage.fromJson(json['branches'] as Map<String, dynamic>),
    functions: json['functions'] == null
        ? null
        : FunctionCoverage.fromJson(json['functions'] as Map<String, dynamic>),
    lines: json['lines'] == null
        ? null
        : LineCoverage.fromJson(json['lines'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$RecordToJson(Record instance) => <String, dynamic>{
      'branches': instance.branches?.toJson(),
      'functions': instance.functions?.toJson(),
      'lines': instance.lines?.toJson(),
      'sourceFile': instance.sourceFile,
    };

Report _$ReportFromJson(Map<String, dynamic> json) {
  return Report(
    json['testName'] as String ?? '',
    (json['records'] as List)?.map((e) =>
            e == null ? null : Record.fromJson(e as Map<String, dynamic>)) ??
        [],
  );
}

Map<String, dynamic> _$ReportToJson(Report instance) => <String, dynamic>{
      'records': instance.records?.map((e) => e?.toJson())?.toList(),
      'testName': instance.testName,
    };
