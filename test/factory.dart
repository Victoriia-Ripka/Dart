// dart compile exe factory.dart -o first.exe


import 'dart:math';


// abstract class Shape {
//   num get area;
// }

// функції верхнього рівня
// Shape shapeFactory(String type) {
//   if (type == "circle") return Circle(2);
//   if (type == "square") return Square(2);
//   throw 'Can\'t create $type. ';
// }

// фабричного конструктора
abstract class Shape {
  factory Shape(String type) {
    if (type == 'circle') return Circle(2);
    if (type == 'square') return Square(2);
    throw 'Can\'t create $type.';
  }

  num get area;
}

class Circle implements Shape {
  final num radius;
  Circle(this.radius);
  num get area => pi * pow(radius, 2);
}

class CircleMock implements Circle {
  num area = 0; // реалізує геттер Circle area
  num radius = 0;
}

class Square implements Shape {
  final num side;
  Square(this.side);
  num get area => pow(side, 2);
}

main() {
  // final circle = Circle(2);
  // final square = Square(2);

  // final circle = shapeFactory("circle");
  // final square = shapeFactory("square");

  final circle = Shape('circle');
  final square = Shape('square');

  print(circle.area);
  print(square.area);
}