part '../parts/result.dart';

class Filter {
  String? query;

  Filter({this.query});
}

class Offset {
  int? page;
  int? limit;

  Offset({this.page, this.limit});
}

class ResultArguments {
  Filter? filter = Filter();
  Offset? offset = Offset(page: 1, limit: 10);
  int? page;
  int? limit;
  String? type;
  String? status;
  List<List<double>>? bounds;
  String? query;
  String? level1;
  String? startDate;
  String? endDate;
  int? personCountMax;
  int? personCountMin;
  String? property;
  bool? ignoreBounds;
  List<String>? tags;
  int? priceMin;
  int? priceMax;
  List<String>? placeOffers;
  int? levels0;
  int? levels1;
  int? levels2;
  String? category;
  String? parent;
  String? zone;
  List<String>? statuses;

  ResultArguments({
    this.filter,
    this.offset,
    this.limit,
    this.page,
    this.type,
    this.bounds,
    this.status,
    this.query,
    this.startDate,
    this.endDate,
    this.level1,
    this.personCountMax,
    this.personCountMin,
    this.property,
    this.ignoreBounds,
    this.tags,
    this.priceMin,
    this.priceMax,
    this.placeOffers,
    this.levels0,
    this.levels1,
    this.levels2,
    this.category,
    this.parent,
    this.zone,
    this.statuses,
  });

  Map<String, dynamic> toJson() => _$ResultArgumentToJson(this);
}

class Result {
  List<dynamic>? rows = [];
  int? count = 0;

  Result({this.rows, this.count});

  factory Result.fromJson(dynamic json, Function fromJson) =>
      _$ResultFromJson(json, fromJson);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}
