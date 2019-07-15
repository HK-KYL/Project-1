import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

// _firebaseService
import '../services/firebase_service.dart';

import 'job_route_paths.dart';
import 'job.dart';

@Component(
  selector: 'job-form-component',
  templateUrl: 'job_form_component.html',
  directives: [coreDirectives, formDirectives, ],
)
class JobFormComponent {

  final Router _router;
  final FirebaseService _firebaseService;

  Job job;

  JobFormComponent(this._router, this._firebaseService){
    job = Job('', '', DateTime.now(), '', '', '', '' ,'' ,'');
  }

  postJob(Job job) async {
    await this._firebaseService.postItem(job);
  }

  goBack() {
    _router.navigate(JobRoutePaths.home.toUrl());
  }

}