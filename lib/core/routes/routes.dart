import 'package:go_router/go_router.dart';
import 'package:tractian/core/routes/route_name.dart';

abstract class AppRoutes {
  static final router = GoRouter(initialLocation: AppRoute.menu.path, routes: [
    GoRoute(
        name: AppRoute.menu.name,
        path: AppRoute.menu.path,
        pageBuilder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
              name: AppRoute.assets.name,
              path: AppRoute.assets.path,
              pageBuilder: (context, state) => DetailsPage(id: state.params['id'])),
        ]),
  ]);
}
