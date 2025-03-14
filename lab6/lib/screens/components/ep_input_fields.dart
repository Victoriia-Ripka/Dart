import 'package:flutter/material.dart';

import '../../data/ep_input.dart';

/// Model representing an EP Input
class EPInputModel {
  String name;
  String coeffUsefulAct;
  String coeffPower;
  String voltage;
  String count;
  String capacity;
  String coefUsage;
  String coeffReactPower;

  EPInputModel({
    this.name = '',
    this.coeffUsefulAct = '',
    this.coeffPower = '',
    this.voltage = '',
    this.count = '',
    this.capacity = '',
    this.coefUsage = '',
    this.coeffReactPower = '',
  });

  factory EPInputModel.fromEPInput(EPInput input) {
    return EPInputModel(
      name: input.name,
      coeffUsefulAct: input.coeffUsefulAct,
      coeffPower: input.coeffPower,
      voltage: input.voltage,
      count: input.count,
      capacity: input.capacity,
      coefUsage: input.coefUsage,
      coeffReactPower: input.coeffReactPower,
    );
  }

  /// Returns a copy of the object with updated values.
  EPInputModel copyWith({
    String? name,
    String? coeffUsefulAct,
    String? coeffPower,
    String? voltage,
    String? count,
    String? capacity,
    String? coefUsage,
    String? coeffReactPower,
  }) {
    return EPInputModel(
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

/// Widget for rendering input fields
class EPInputFields extends StatefulWidget {
  final EPInputModel epInput;
  final Function(EPInputModel) onUpdate;

  const EPInputFields({
    super.key,
    required this.epInput,
    required this.onUpdate,
  });

  @override
  _EPInputFieldsState createState() => _EPInputFieldsState();
}

class _EPInputFieldsState extends State<EPInputFields> {
  late Map<String, TextEditingController> _controllers;

  /// List of fields and their corresponding model keys
  final List<Map<String, String>> _fields = [
    {'label': "Найменування ЕП", 'key': 'name'},
    {'label': "Номінальне значення ККД", 'key': 'coeffUsefulAct'},
    {'label': "Коефіцієнт потужності навантаження", 'key': 'coeffPower'},
    {'label': "Напруга навантаження", 'key': 'voltage'},
    {'label': "Кількість ЕП", 'key': 'count'},
    {'label': "Номінальна потужність ЕП", 'key': 'capacity'},
    {'label': "Коефіцієнт використання", 'key': 'coefUsage'},
    {'label': "Коефіцієнт реактивної потужності", 'key': 'coeffReactPower'},
  ];

  @override
  void initState() {
    super.initState();
    _controllers = {
      for (var field in _fields)
        field['key']!: TextEditingController(text: _getValue(field['key']!))
    };
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant EPInputFields oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.epInput != widget.epInput) {
      _controllers.forEach((key, controller) {
        controller.text = _getValue(key);
      });
    }
  }

  /// Gets the value from the EPInputModel based on the key
  String _getValue(String key) {
    switch (key) {
      case 'name':
        return widget.epInput.name;
      case 'coeffUsefulAct':
        return widget.epInput.coeffUsefulAct;
      case 'coeffPower':
        return widget.epInput.coeffPower;
      case 'voltage':
        return widget.epInput.voltage;
      case 'count':
        return widget.epInput.count;
      case 'capacity':
        return widget.epInput.capacity;
      case 'coefUsage':
        return widget.epInput.coefUsage;
      case 'coeffReactPower':
        return widget.epInput.coeffReactPower;
      default:
        return '';
    }
  }

  /// Updates the model when a field changes
  void _onFieldChanged(String key, String value) {
    widget.onUpdate(widget.epInput.copyWith(
      name: key == 'name' ? value : widget.epInput.name,
      coeffUsefulAct: key == 'coeffUsefulAct' ? value : widget.epInput.coeffUsefulAct,
      coeffPower: key == 'coeffPower' ? value : widget.epInput.coeffPower,
      voltage: key == 'voltage' ? value : widget.epInput.voltage,
      count: key == 'count' ? value : widget.epInput.count,
      capacity: key == 'capacity' ? value : widget.epInput.capacity,
      coefUsage: key == 'coefUsage' ? value : widget.epInput.coefUsage,
      coeffReactPower: key == 'coeffReactPower' ? value : widget.epInput.coeffReactPower,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _fields.map((field) {
        return EPTextField(
          label: field['label']!,
          controller: _controllers[field['key']]!,
          keyboardType: _isNumericField(field['key']!) ? TextInputType.number : TextInputType.text,
          onChanged: (value) => _onFieldChanged(field['key']!, value),
        );
      }).toList(),
    );
  }

  /// Checks if the field should use a numeric keyboard
  bool _isNumericField(String key) {
    return [
      'coeffUsefulAct',
      'coeffPower',
      'voltage',
      'count',
      'capacity',
      'coefUsage',
      'coeffReactPower'
    ].contains(key);
  }
}

/// Separate widget for a text field
class EPTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function(String) onChanged;

  const EPTextField({
    Key? key,
    required this.label,
    required this.controller,
    required this.keyboardType,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        controller: controller,
        onChanged: onChanged,
      ),
    );
  }
}