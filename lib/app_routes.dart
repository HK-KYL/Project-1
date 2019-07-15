import 'package:angular_router/angular_router.dart';

import 'src/dashboard/dashboard_component.template.dart' as dashboard_template;
import 'src/job/job_list_component.template.dart' as job_list_template;

import 'app_route_paths.dart';
export 'app_route_paths.dart';

class AppRoutes {

  static final dashboard = RouteDefinition(
    routePath: AppRoutePaths.dashboard,
    component: dashboard_template.DashboardComponentNgFactory,
  );
  static final jobs = RouteDefinition(
    routePath: AppRoutePaths.jobs,
    component: job_list_template.JobListComponentNgFactory,
  );

  static final all = <RouteDefinition>[
    dashboard,
    jobs,

    RouteDefinition.redirect(
      path: '',
      redirectTo: AppRoutePaths.jobs.toUrl(),
    ),

  ];
  
}
