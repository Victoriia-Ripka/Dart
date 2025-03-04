import 'package:json_annotation/json_annotation.dart';

part 'ep_input.g.dart';

@JsonSerializable()
class EPInput {
  String name;
  String coeffUsefulAct;
  String coeffPower;
  String voltage;
  String count;
  String capacity;
  String coefUsage;
  String coeffReactPower;

  EPInput({
    this.name = '',
    this.coeffUsefulAct = '',
    this.coeffPower = '',
    this.voltage = '',
    this.count = '',
    this.capacity = '',
    this.coefUsage = '',
    this.coeffReactPower = '',
  });

  factory EPInput.fromJson(Map<String, dynamic> json) => _$EPInputFromJson(json);
  Map<String, dynamic> toJson() => _$EPInputToJson(this);
}