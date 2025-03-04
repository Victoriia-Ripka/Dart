// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ep_input.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EPInput _$EPInputFromJson(Map<String, dynamic> json) => EPInput(
  name: json['name'] as String? ?? '',
  coeffUsefulAct: json['coeffUsefulAct'] as String? ?? '',
  coeffPower: json['coeffPower'] as String? ?? '',
  voltage: json['voltage'] as String? ?? '',
  count: json['count'] as String? ?? '',
  capacity: json['capacity'] as String? ?? '',
  coefUsage: json['coefUsage'] as String? ?? '',
  coeffReactPower: json['coeffReactPower'] as String? ?? '',
);

Map<String, dynamic> _$EPInputToJson(EPInput instance) => <String, dynamic>{
  'name': instance.name,
  'coeffUsefulAct': instance.coeffUsefulAct,
  'coeffPower': instance.coeffPower,
  'voltage': instance.voltage,
  'count': instance.count,
  'capacity': instance.capacity,
  'coefUsage': instance.coefUsage,
  'coeffReactPower': instance.coeffReactPower,
};
