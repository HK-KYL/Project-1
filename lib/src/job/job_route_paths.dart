import 'package:angular_router/angular_router.dart';

import 'package:angular_app/app_route_paths.dart' as _parent;

// Export
export 'package:angular_app/app_route_paths.dart' show idParam, getId;

class JobRoutePaths {

  static final form = RoutePath(
    path: 'new',
    parent: _parent.AppRoutePaths.jobs,
  );
  static final job = RoutePath(
    path: ':${_parent.idParam}',
    parent: _parent.AppRoutePaths.jobs,
  );
  static final home = RoutePath(
    path: '',
    parent: _parent.AppRoutePaths.jobs,
    useAsDefault: true,
  );
  
}
