enum AppRoute {
  menu._(name: 'menu', path: '/'),
  assets._(name: 'assets', path: '/assets');

  final String name;
  final String path;

  const AppRoute._({required this.name, required this.path});
}
