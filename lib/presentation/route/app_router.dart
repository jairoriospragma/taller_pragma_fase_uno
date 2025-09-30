import 'package:go_router/go_router.dart';
import 'package:taller_pragma_fase_uno/domain/entities/contact.dart';
import 'package:taller_pragma_fase_uno/presentation/pages/detail/detail_screen.dart';
import 'package:taller_pragma_fase_uno/presentation/pages/form/form_screen.dart';
import 'package:taller_pragma_fase_uno/presentation/pages/home/home_screen.dart';
import 'package:taller_pragma_fase_uno/presentation/route/string_rout_names.dart';

class AppRouter {
  static final GoRouter router =
      GoRouter(initialLocation: StringRoutNames.homeScreen, routes: [
    GoRoute(
      path: StringRoutNames.homeScreen,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: StringRoutNames.detailScreen,
      builder: (context, state) =>
          DetailScreen(contact: state.extra as Contact),
    ),
    GoRoute(
      path: StringRoutNames.formScreen,
      builder: (context, state) => const FormScreen(),
    ),
  ]);
}
