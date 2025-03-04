import 'package:flutter/material.dart';

class EPInput2 {
  String name;
  String coeffUsefulAct;
  String coeffPower;
  String voltage;
  String count;
  String capacity;
  String coefUsage;
  String coeffReactPower;

  EPInput2({
    this.name = '',
    this.coeffUsefulAct = '',
    this.coeffPower = '',
    this.voltage = '',
    this.count = '',
    this.capacity = '',
    this.coefUsage = '',
    this.coeffReactPower = '',
  });

  EPInput2 copyWith({
    String? name,
    String? coeffUsefulAct,
    String? coeffPower,
    String? voltage,
    String? count,
    String? capacity,
    String? coefUsage,
    String? coeffReactPower,
  }) {
    return EPInput2(
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

class EPInputFields extends StatelessWidget {
  final EPInput2 epInput;
  final Function(EPInput2) onUpdate;

  const EPInputFields({
    Key? key,
    required this.epInput,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(
          label: "Найменування ЕП",
          value: epInput.name,
          onChanged: (value) => onUpdate(epInput.copyWith(name: value)),
        ),
        _buildTextField(
          label: "Номінальне значення ККД",
          value: epInput.coeffUsefulAct,
          keyboardType: TextInputType.number,
          onChanged: (value) => onUpdate(epInput.copyWith(coeffUsefulAct: value)),
        ),
        _buildTextField(
          label: "Коефіцієнт потужності навантаження",
          value: epInput.coeffPower,
          keyboardType: TextInputType.number,
          onChanged: (value) => onUpdate(epInput.copyWith(coeffPower: value)),
        ),
        _buildTextField(
          label: "Напруга навантаження",
          value: epInput.voltage,
          keyboardType: TextInputType.number,
          onChanged: (value) => onUpdate(epInput.copyWith(voltage: value)),
        ),
        _buildTextField(
          label: "Кількість ЕП",
          value: epInput.count,
          keyboardType: TextInputType.number,
          onChanged: (value) => onUpdate(epInput.copyWith(count: value)),
        ),
        _buildTextField(
          label: "Номінальна потужність ЕП",
          value: epInput.capacity,
          keyboardType: TextInputType.number,
          onChanged: (value) => onUpdate(epInput.copyWith(capacity: value)),
        ),
        _buildTextField(
          label: "Коефіцієнт використання",
          value: epInput.coefUsage,
          keyboardType: TextInputType.number,
          onChanged: (value) => onUpdate(epInput.copyWith(coefUsage: value)),
        ),
        _buildTextField(
          label: "Коефіцієнт реактивної потужності",
          value: epInput.coeffReactPower,
          keyboardType: TextInputType.number,
          onChanged: (value) => onUpdate(epInput.copyWith(coeffReactPower: value)),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String value,
    required Function(String) onChanged,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        onChanged: onChanged,
        controller: TextEditingController(text: value),
      ),
    );
  }
}