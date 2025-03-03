import 'package:go_router/go_router.dart';
import 'screens/entry_screen.dart';
import 'screens/calculator/calculator1_screen.dart';
import 'screens/calculator/calculator2_screen.dart';
import 'screens/calculator/calculator3_screen.dart';
import 'services/calculator_service.dart';

final CalculatorService calculatorService = CalculatorService();

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => EntryScreen()),
    GoRoute(path: '/calculator1', builder: (context, state) => Calculator1Screen(goBack: () {  },)),
    GoRoute(path: '/calculator2', builder: (context, state) => Calculator2Screen(goBack: () {  }, calculatorService: calculatorService)),
    GoRoute(path: '/calculator3', builder: (context, state) => Calculator3Screen(goBack: () {  }, calculatorService: calculatorService)),
  ],
);