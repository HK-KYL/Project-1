import 'package:angular_router/angular_router.dart';

const idParam = 'id';

class AppRoutePaths {
  static final dashboard = RoutePath(path: 'dashboard');
  static final jobs = RoutePath(path: 'jobs');
}

String getId(Map<String, String> parameters) {
  final id = parameters[idParam];
  return id == null ? null : id;
}