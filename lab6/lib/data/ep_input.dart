import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart'; // For @immutable

part 'ep_input.g.dart';

@immutable
@JsonSerializable()
class EPInput {
  final String name;
  final String coeffUsefulAct;
  final String coeffPower;
  final String voltage;
  final String count;
  final String capacity;
  final String coefUsage;
  final String coeffReactPower;

  const EPInput({
    this.name = '',
    this.coeffUsefulAct = '',
    this.coeffPower = '',
    this.voltage = '',
    this.count = '',
    this.capacity = '',
    this.coefUsage = '',
    this.coeffReactPower = '',
  });

  /// Factory constructor for deserialization.
  factory EPInput.fromJson(Map<String, dynamic> json) => _$EPInputFromJson(json);

  /// Method for serialization.
  Map<String, dynamic> toJson() => _$EPInputToJson(this);

  /// Creates a copy of the instance with updated values.
  EPInput copyWith({
    String? name,
    String? coeffUsefulAct,
    String? coeffPower,
    String? voltage,
    String? count,
    String? capacity,
    String? coefUsage,
    String? coeffReactPower,
  }) {
    return EPInput(
      name: name ?? this.name,
      coeffUsefulAct: coeffUsefulAct ?? this.coeffUsefulAct,
      coeffPower: coeffPower ?? this.coeffPower,
      voltage: voltage ?? this.voltage,
      count: count ?? this.count,
      capacity: capacity ?? this.capacity,
      coefUsage: coefUsage ?? this.coefUsage,
      coeffReactPower: coeffReactPower ?? this.coeffReactPower,
    );
  }
}