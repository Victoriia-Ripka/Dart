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
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => EntryScreen(),
    ),
    GoRoute(
      path: '/calculator1',
      name: 'calculator1',
      builder: (context, state) => Calculator1Screen(
          goBack: () => context.go('/')
      ),
    ),
    GoRoute(
      path: '/calculator2',
      name: 'calculator2',
      builder: (context, state) =>
          Calculator2Screen(
              goBack: () => context.go('/'),
              calculatorService: calculatorService
          ),
    ),
    GoRoute(
      path: '/calculator3',
      name: 'calculator3',
      builder: (context, state) =>
          Calculator3Screen(
              goBack: () => context.go('/'),
              calculatorService: calculatorService
          ),
    ),
  ],
);