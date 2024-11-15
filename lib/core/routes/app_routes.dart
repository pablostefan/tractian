import 'package:go_router/go_router.dart';
import 'package:tractian/core/routes/app_route.dart';
import 'package:tractian/features/assets/presentation/pages/assets_page.dart';
import 'package:tractian/features/menu/presentation/pages/menu_page.dart';

abstract class AppRoutes {
  static final router = GoRouter(
    initialLocation: AppRoute.menu.path,
    routes: [
      GoRoute(
        name: AppRoute.menu.name,
        path: AppRoute.menu.path,
        builder: (context, state) => const MenuPage(),
        routes: [
          GoRoute(
              name: AppRoute.assets.name,
              path: AppRoute.assets.path,
              builder: (context, state) => AssetsPage(companyId: state.extra as String)),
        ],
      ),
    ],
  );
}
