import 'package:angular_router/angular_router.dart';

import 'job_component.template.dart' as job_template;
import 'job_list_home_component.template.dart' as job_list_home_template;
import 'job_form_component.template.dart' as job_form_template;

import 'job_route_paths.dart';
export 'job_route_paths.dart';

class JobRoutes {

  static final job = RouteDefinition(
    routePath: JobRoutePaths.job,
    component: job_template.JobComponentNgFactory,
  );
  static final home = RouteDefinition(
    routePath: JobRoutePaths.home,
    component: job_list_home_template.JobListHomeComponentNgFactory,
    useAsDefault: true,
  );
  static final form = RouteDefinition(
    routePath: JobRoutePaths.form,
    component: job_form_template.JobFormComponentNgFactory,
  );
  static final all = <RouteDefinition>[
    form,
    job,
    home,
    
  ];
  
}
