import 'package:flutter/material.dart';

class FancyButton extends StatefulWidget {
  final String text;
  final VoidCallback onClick;
  final TextStyle textStyle;

  const FancyButton({
    super.key,
    required this.text,
    required this.onClick,
    this.textStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  });

  @override
  _FancyButtonState createState() => _FancyButtonState();
}

class _FancyButtonState extends State<FancyButton> {
  bool _isPressed = false;

  void _handlePress() {
    setState(() => _isPressed = true);
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() => _isPressed = false);
      widget.onClick();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handlePress,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        transform: Matrix4.identity()..scale(_isPressed ? 0.95 : 1.0),
        decoration: BoxDecoration(
          color: _isPressed ? const Color(0xFF3700B3) : const Color(0xFF6200EE),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Center(
          child: Text(
            widget.text,
            style: widget.textStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}