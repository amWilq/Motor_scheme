// import 'package:motor_scheme/models/type_bike.dart';

final String tableBike = 'bike';

class BikeFields {
  static final List<String> values = [id, mark, model, year, type_bike];

  static const String id = 'id';
  static const String mark = 'mark';
  static const String model = 'model';
  static const String year = 'year';
  static const String type_bike = 'type_bike';
}

class TypeBike {
  final int id;
  final String name;

  const TypeBike({required this.id, required this.name});

  static TypeBike fromJson(Map<String, Object?> json) => TypeBike(
        id: json['id'] as int,
        name: json['name'] as String,
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
      };
}

class Bike {
  final int? id;
  final int? mark;
  final String? model;
  final String? year;
  final TypeBike type_bike;

  const Bike(
      {this.id,
      required this.mark,
      required this.model,
      required this.year,
      required this.type_bike});

  Bike copy({
    int? id,
    int? mark,
    String? model,
    String? year,
    TypeBike? type_bike,
  }) =>
      Bike(
        id: id ?? this.id,
        mark: mark ?? this.mark,
        model: model ?? this.model,
        year: year ?? this.year,
        type_bike: type_bike ?? this.type_bike,
      );

  static Bike fromJson(Map<String, Object?> json) => Bike(
        id: json[BikeFields.id] as int?,
        mark: json[BikeFields.mark] as int,
        model: json[BikeFields.model] as String,
        year: json[BikeFields.year] as String,
        type_bike: TypeBike.fromJson(
            json[BikeFields.type_bike] as Map<String, Object?>),
      );

  Map<String, Object?> toJson() => {
        BikeFields.id: id,
        BikeFields.mark: mark,
        BikeFields.model: model,
        BikeFields.year: year,
        BikeFields.type_bike: type_bike.toJson(),
      };
}
